module ApplicationHelper

  def print_comments(comments, indent = 0, reply_look)
    (comments.length).times do |comment|
      if comments[comment] != nil && comments[comment].response_to == reply_look then
        yield comments[comment], indent
        print_comments(comments, indent + 1, comments[comment][:id]) { |x, y| yield x, y }
        comments[comment] = nil 
      end
    end
  end 

  def process_post(post)
    subs =
    [
	["[img]", "<img src=\""],
	["[/img]", "\" />"],
	["[caption]", "<div class=\"caption\">"],
	["[/caption]", "<\/div>"]
    ]

    subs.each { |pair| post.gsub!(pair[0], pair[1]) }
    return post

  end

end
