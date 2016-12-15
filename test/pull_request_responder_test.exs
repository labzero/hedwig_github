defmodule PullRequestResponderTest do
  use ExUnit.Case
  use Hedwig.RobotCase

  @tag start_robot: true, name: "clippy", responders: [{HedwigGithub.Responder, []}]
  test "github-prs displays pull requests", %{adapter: adapter, msg: msg} do
    send adapter, {:message, %{msg | text: "github prs labzero/lunch"}}
    Enum.each(0..1, fn _ -> 
      assert_receive {:message, %{text: text}}, 5000
      assert String.contains?(text, "Author:")
      end)
  end
end