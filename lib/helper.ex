defmodule HedwigGithub.Helper do
  alias HedwigGithub.Formatter

  @github_api Application.get_env(:hedwig_github, :github_api) || HedwigGithub.HttpClient

  def commits(org, repo, limit \\ 5) do
    build_response(@github_api.commits(org, repo, limit))
  end

  def pull_requests(org, repo, limit \\ 5) do
    build_response(@github_api.pull_requests(org, repo, limit))
  end

  def short_url(url) do
    @github_api.shorten_url(url)
  end

  defp build_response(github_response) do
    case github_response do
      {:ok, items} ->
        Enum.map(items, &Formatter.format/1)
      {:error, reason} ->
        ["Error: #{reason}"]
    end
  end

end