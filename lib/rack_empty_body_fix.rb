# Rack Empty Post Body Fix
#
# This class is a Rack Middleware that checks for
# an empty POST body (an MSIE issue, naturally)
# and errors out if found.
class RackEmptyBodyFix
  def initialize(app)
    @app = app
  end

  def call(env)
    if env['POST_BODY']
      body = env['POST_BODY'].read

      if body && body.empty?
        return [408, { 'Content-Type' => 'text/plain' }, ['empty body']]
      end

      env['POST_BODY'].rewind
    end

    @app.call env
  end
end

