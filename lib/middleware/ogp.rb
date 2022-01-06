class Ogp
  TARGET_AGENTS = [
    /^Slackbot-LinkExpanding/
  ]

  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, body = @app.call(env)
    if target_path?(env) && target_agent?(env)
      headers["Content-Type"] = "text/html; charset=UTF-8"
      body = body.each.map { |s| reform_body(s) }
    end
    [status, headers, body]
  end

  private

  def target_path?(env)
    env['REQUEST_PATH']&.start_with?('/gachas')
  end

  def target_agent?(env)
    TARGET_AGENTS.any? { |regexp| regexp.match?(env["HTTP_USER_AGENT"]) }
  end

  def reform_body(body)
    %(<html><head><meta property="og:og:description" content="#{JSON.parse(body).join(", ")}"/></head></html>)
  end
end