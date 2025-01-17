# frozen_string_literal: true

class HomeFeed < Feed
  def initialize(account)
    @account = account
    super(:home, account.id, account.geography_electorates_id)
  end

  def regenerating?
    redis.exists?("account:#{@account.id}:regeneration")
  end
end
