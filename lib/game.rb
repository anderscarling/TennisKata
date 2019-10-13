class Game
  SCORES = [0, 15, 30, 40]

  def initialize
    @player1_score = 0
    @player2_score = 0
  end

  private def score_diff
    @player1_score - @player2_score
  end

  private def is_deuce
    @player1_score > 2 && score_diff == 0
  end

  private def is_early_game
    !is_deuce &&
      @player1_score < 4 && @player2_score < 4
  end

  private def is_advantage_p1
    !is_early_game &&
      score_diff == 1
  end

  private def is_advantage_p2
    !is_early_game &&
      score_diff == -1
  end

  private def is_winner_p1
    !is_early_game &&
      score_diff >= 2
  end

  private def is_winner_p2
    !is_early_game &&
      score_diff <= -2
  end

  def score
    case
    when is_deuce
      "Deuce"
    when is_early_game
      "#{SCORES.fetch(@player1_score)} - #{SCORES.fetch(@player2_score)}"
    when is_advantage_p1
      "Advantage Player #1!"
    when is_advantage_p2
      "Advantage Player #2!"
    when is_winner_p1
      "A winner is Player #1!"
    when is_winner_p2
      "A winner is Player #2!"
    end
  end

  private def assert_game_not_finished!
    if is_winner_p1 || is_winner_p2
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
