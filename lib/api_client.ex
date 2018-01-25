defmodule HedwigGithub.ApiClient do

  @doc "return the latest n commits from the specified repo"
  @callback commits(org :: String.t, repo :: String.t, limit :: integer()) :: [any]

  @doc "return the latest n open pull requests from the specified repo"
  @callback pull_requests(org :: String.t, repo :: String.t, limit :: integer()) :: [any]

  @doc "shorten the given url"
  @callback shorten_url(url :: String.t) :: String.t
end