# frozen_string_literal: true

class ListFeed < Feed
  def initialize(list)
    super(:list, list.id, nil)
  end
end
