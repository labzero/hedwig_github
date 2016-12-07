defmodule HedwigGithub.Formatter do
  alias HedwigGithub.Helper
  # commit
  def format(%{"author" => %{"login" => login}, "sha" => sha, "html_url" => url, "commit" => %{"message" => message}}) do
    "Author: *#{login}*\n_#{message}_\n#{Helper.short_url(url)} "    
  end

  # pull request
  def format(%{"user" => %{"login" => login}, "title" => title, "url" => url}) do
    "*#{title}*\nAuthor: #{login}\n#{Helper.short_url(url)}"
  end

  def format(_) do
    "Unexpected response from Github"
  end  
end