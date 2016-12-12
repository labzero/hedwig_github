defmodule HedwigGithub.HttpClient do

  @behaviour HedwigGithub.ApiClient
    
  @url_shortener "https://git.io"
  @github_url "https://api.github.com"
  @access_token Application.get_env(:hedwig_github, :github_access_token)

  def commits(org, repo, limit) do
    case HTTPoison.get(commits_url(org, repo, limit), [auth_header(@access_token)]) do
      {:ok, %HTTPoison.Response{status_code: status}} when status >= 400 -> 
        {:error, "HTTP status code: #{status}"}
      {:error, %HTTPoison.Error{reason: reason}} -> 
        {:error, reason}  
      {:ok, %HTTPoison.Response{body: json}} ->          
        {:ok, Poison.decode!(json)}         
    end
  end

  def pull_requests(org, repo, limit) do
    IO.puts(pull_requests_url(org, repo, limit))
    case HTTPoison.get(pull_requests_url(org, repo, limit), [auth_header(@access_token)]) do
      {:ok, %HTTPoison.Response{status_code: status}} when status >= 400 -> 
        {:error, "HTTP status code: #{status}"}
      {:error, %HTTPoison.Error{reason: reason}} -> 
        {:error, reason}  
      {:ok, %HTTPoison.Response{body: json}} ->          
        {:ok, Poison.decode!(json)}         
    end
  end

  def shorten_url(url) do      
    case HTTPoison.post(@url_shortener, {:form, [{"url", url}]}) do
      {:ok, %HTTPoison.Response{headers: headers}} 
        -> :proplists.get_value("Location", headers)
      _ -> "Invalid Url"
    end  
  end

  defp pull_requests_url(org, repo, limit \\ 5) do
    "#{repo_url(org, repo)}/pulls?per_page=#{limit}"    
  end

  defp commits_url(org, repo, limit \\ 5) do
    "#{repo_url(org, repo)}/commits?per_page=#{limit}"    
  end

  defp repo_url(org, repo) do
    "#{@github_url}/repos/#{org}/#{repo}"
  end 

  defp auth_header(token) do
    {"Authorization", "token #{token}"}    
  end  

end