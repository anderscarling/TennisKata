class Game
  SCORES = [0, 15, 30, 40]

  def initialize
    @player1_score = 0
    @player2_score = 0
  end

  private def score_diff
    @player1_score - @player2_score
  end

  private def is_early_game
    [@player1_score, @player2_score].min <= 2 &&
      [@player1_score, @player2_score].max <= 3
  end

  private def is_deuce
    !is_early_game &&
      score_diff == 0
  end

  private def is_advantage
    !is_early_game &&
      score_diff.abs == 1
  end

  private def is_game_finished
    !is_early_game &&
      score_diff.abs >= 2
  end

  private def leading_player
    score_diff > 0 ? "Player #1" : "Player #2"
  end

  def score
    case
    when is_early_game
      "#{SCORES.fetch(@player1_score)} - #{SCORES.fetch(@player2_score)}"
    when is_deuce
      "Deuce"
    when is_advantage
      "Advantage #{leading_player}!"
    when is_game_finished
      "A winner is #{leading_player}!"
    end
  end

  private def assert_game_not_finished!
    if is_game_finished
      raise RuntimeError, "Game is finshed"
    end
  end

  def award_point_to_player1
    assert_game_not_finished!

    @player1_score += 1
  end

  def award_point_to_player2
    assert_game_not_finished!

    @player2_score += 1
  end
end
