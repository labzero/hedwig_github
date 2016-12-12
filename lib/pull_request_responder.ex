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
    IO.puts("received PR request")
    org = message.matches["org"]
    repo = message.matches["repo"]    
    send_messages(Helper.pull_requests(org, repo), message)    
  end

  def send_messages(prs, message) when length(prs) > 0 do
    IO.puts("have prs")
    Enum.each(prs, fn commit -> send message, commit end)    
  end

  def send_messages(_, message) do
    IO.puts("don't have prs")
    send message, "No open PRs for that repo"
  end
end
  
  
  