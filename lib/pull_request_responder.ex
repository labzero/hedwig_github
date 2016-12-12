defmodule HedwigGithub.PullRequestResponder do
  @moduledoc """
  Fetches the last 5 open PRs for a Github repo

  It requires a github access token, configured like so.
  
  config :hedwig_github, :github_api_token, "your_access_token"

  """
  use Hedwig.Responder
  alias HedwigGithub.Helper

  @usage """
  github-prs <org>/<repo> - display the last 5 open pull requests for the repo 
  """
  hear ~r/^github-prs (?<org>.*)\/(?<repo>.*)/i, message do
    org = message.matches["org"]
    repo = message.matches["repo"]
    Enum.each(Helper.pull_requests(org, repo), fn commit -> send message, commit end)    
  end

end
  
  
  