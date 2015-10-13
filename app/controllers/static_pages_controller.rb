class StaticPagesController < ApplicationController
  before_action :get_all_tags

  def home
    @entries = [] # Array of hashes
    @tags_hash = Hash.new(0)
    @content = ContentView.all
    @content.each do |content|
      content.tag_ids.each do |tag|
          @tags_hash[tag] +=1
      end
    end

    @tags.each do |tag|
      # Get current tag's font size
      _class =
        case @tags_hash[tag.id]
        when 0..(@content.count / 8) then 'sm'
        when (@content.count / 8 + 1)..(@content.count / 7) then 'nm'
        else 'big'
        end

      @entries << { tag: tag, css_class: _class }
    end
  end

  private
    def get_all_tags
      @tags = Tag.all
    end
end
