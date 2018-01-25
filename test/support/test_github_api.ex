defmodule HedwigGithub.TestGithubApi do

  @behaviour HedwigGithub.ApiClient

  def commits(_org, _repo, _limit) do
    {:ok, fake_commits()}
  end

  def pull_requests(_org, _repo, _limit) do
    {:ok, fake_prs()}
  end

  def shorten_url(_url) do
    "http://example.com/short"
  end

  defp fake_commits do
    [
      fake_commit("alice", "abcd", "fixed stuff"),
      fake_commit("bob", "1234", "broke stuff")
    ]
  end

  defp fake_prs do
    [
      fake_pr("alice", "change all the stuff"),
      fake_pr("bob", "rewrite everything")
    ]
  end

  defp fake_commit(login, sha, message) do
    %{"author" => %{"login" => login}, "sha" => sha, "html_url" => "http://example.com/#{sha}", "commit" => %{"message" => message}}
  end

  defp fake_pr(login, title) do
    %{"user" => %{"login" => login}, "title" => title, "url" =>  "http://example.com/#{login}"}
  end
end