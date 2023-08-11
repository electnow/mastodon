export DOCKER_BUILDKIT=1
docker pull $ECR_REGISTRY/$ECR_REPOSITORY:build || true # pull base layer
docker pull $ECR_REGISTRY/$ECR_REPOSITORY:release || true # pull latest layer
docker build --target build --cache-from $ECR_REGISTRY/$ECR_REPOSITORY:build --build-arg BUILDKIT_INLINE_CACHE=1 -t $ECR_REGISTRY/$ECR_REPOSITORY:build .
docker push $ECR_REGISTRY/$ECR_REPOSITORY:build

docker build --cache-from $ECR_REGISTRY/$ECR_REPOSITORY:build --cache-from $ECR_REGISTRY/$ECR_REPOSITORY:release --build-arg BUILDKIT_INLINE_CACHE=1 -t $ECR_REGISTRY/$ECR_REPOSITORY:release -t $ECR_REGISTRY/$ECR_REPOSITORY:$IMAGE_TAG -t $ECR_REGISTRY/$ECR_REPOSITORY:latest .

docker push $ECR_REGISTRY/$ECR_REPOSITORY:$IMAGE_TAG
docker push $ECR_REGISTRY/$ECR_REPOSITORY:release
docker push $ECR_REGISTRY/$ECR_REPOSITORY:latest
echo "image=$ECR_REGISTRY/$ECR_REPOSITORY:$IMAGE_TAG" | tee $GITHUB_OUTPUT