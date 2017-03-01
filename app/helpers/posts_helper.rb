module PostsHelper

#once posts have an author to them, put a 'where' in the posted/unposted methods
  def list_posted()
    Post.where.not(posted: nil).map {|i| [i.id.to_s + ". " + i.title, i.id.to_s] }
  end

  def list_unposted()
    Post.where(posted: nil).map {|i| [i.id.to_s + ". " + i.title, i.id.to_s] }
  end

  def string_to_html(post)
    #one day, might be necessary to modify posts thusly (comments?)
  end

  def prev_and_next(this_post_id)

    post_list = Post.where.not(posted: nil).select(:url, :posted, :title, :id).order(posted: :desc).to_a
    post_id = post_list.index { |x| x.id.to_i == this_post_id.to_i } 
    out_hash = Hash.new(nil)
    if post_id < (post_list.length - 1) then
      out_hash[:prevurl] = post_list[post_id.to_i + 1].url
      out_hash[:prevtitle] = post_list[post_id.to_i + 1].title 
    end
    if post_id != 0 then
      out_hash[:nexturl] = post_list[post_id.to_i - 1].url
      out_hash[:nexttitle] = post_list[post_id.to_i - 1].title
    end
    return out_hash
  end

end
