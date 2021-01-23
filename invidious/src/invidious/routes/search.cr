class Invidious::Routes::Search < Invidious::Routes::BaseRoute
  def opensearch(env)
    locale = LOCALES[env.get("preferences").as(Preferences).locale]?
    env.response.content_type = "application/opensearchdescription+xml"

    XML.build(indent: "  ", encoding: "UTF-8") do |xml|
      xml.element("OpenSearchDescription", xmlns: "http://a9.com/-/spec/opensearch/1.1/") do
        xml.element("ShortName") { xml.text "Invidious" }
        xml.element("LongName") { xml.text "Invidious Search" }
        xml.element("Description") { xml.text "Search for videos, channels, and playlists on Invidious" }
        xml.element("InputEncoding") { xml.text "UTF-8" }
        xml.element("Image", width: 48, height: 48, type: "image/x-icon") { xml.text "#{HOST_URL}/favicon.ico" }
        xml.element("Url", type: "text/html", method: "get", template: "#{HOST_URL}/search?q={searchTerms}")
      end
    end
  end

  def results(env)
    locale = LOCALES[env.get("preferences").as(Preferences).locale]?

    query = env.params.query["search_query"]?
    query ||= env.params.query["q"]?
    query ||= ""

    page = env.params.query["page"]?.try &.to_i?
    page ||= 1

    if query
      env.redirect "/search?q=#{URI.encode_www_form(query)}&page=#{page}"
    else
      env.redirect "/"
    end
  end

  def search(env)
    locale = LOCALES[env.get("preferences").as(Preferences).locale]?
    region = env.params.query["region"]?

    query = env.params.query["search_query"]?
    query ||= env.params.query["q"]?
    query ||= ""

    return env.redirect "/" if query.empty?

    page = env.params.query["page"]?.try &.to_i?
    page ||= 1

    user = env.get? "user"

    begin
      search_query, count, videos, operators = process_search_query(query, page, user, region: nil)
    rescue ex
      return error_template(500, ex)
    end

    operator_hash = {} of String => String
    operators.each do |operator|
      key, value = operator.downcase.split(":")
      operator_hash[key] = value
    end

    env.set "search", query
    templated "search"
  end
end
