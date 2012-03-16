module MetaHelper
  def meta_title(showTitulo)
	content_for :titles do
        content = "<title>#{showTitulo}</title>"
        content
    end
  end
  def meta_description(showContent)
    content_for :headers do
      content = "<meta name=\"description\" content=\"#{showContent}\" />\n"
      content
    end
  end

  def meta_keywords(showKeywords)
    content_for :headers do
      content = "<meta name=\"keywords\" content=\"#{showKeywords}\" />"
      content
    end
  end
end

