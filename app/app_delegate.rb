class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @ra = ReverseAuth.new
    @ra.getData
    true
  end
end

class ReverseAuth

  def getData
    url = NSURL.URLWithString "https://api.twitter.com/oauth/request_token"
    dict = {x_auth_mode: "reverse_auth"}
    @step1Request = TWSignedRequest.alloc.initWithURL(url, parameters: dict, requestMethod: TWSignedRequestMethodPOST)
    @step1Request.consumerKey = 'CONSUMER_KEY'
    @step1Request.consumerSecret = 'CONSUMER_SECRET'
    Dispatch::Queue.concurrent.async do
      @step1Request.performRequestWithHandler(->(data, resp, err){
        Dispatch::Queue.main.async do
          setData(data)
        end
      })
    end
  end

  def setData(data)
    puts data
  end

end
