defmodule HedwigGithub.Responder do
  @moduledoc """
  Fetches the last 5 commits for a Github repo

  It requires a github access token, configured like so.

  config :hedwig_github, :github_api_token, "your_access_token"

  """
  use Hedwig.Responder
  alias HedwigGithub.Helper

  @usage """
  github activity <org>/<repo> - display the last 5 commits for the repo
  github prs <org>/<repo> - display the last 5 open pull requests for the repo
  """
  hear ~r/^github activity (?<org>.*)\/(?<repo>.*)/i, message do
    org = message.matches["org"]
    repo = message.matches["repo"]
    Enum.each(Helper.commits(org, repo), fn commit -> send message, commit end)
  end

  hear ~r/^github prs (?<org>.*)\/(?<repo>.*)/i, message do
    org = message.matches["org"]
    repo = message.matches["repo"]
    send_messages(Helper.pull_requests(org, repo), message)
  end

  def send_messages(prs, message) when length(prs) > 0 do
    Enum.each(prs, fn commit -> send message, commit end)
  end

  def send_messages(_, message) do
    send message, "There are currently no open pull requests."
  end

end
