require 'game'

RSpec.describe Game do
  subject { Game.new }

  def award_points(player1: 0, player2: 0)
    player1.times { subject.award_point_to_player1() }
    player2.times { subject.award_point_to_player2() }
  end

  it "should have correct initial scores" do
    expect(subject.score).to eq("0 - 0")
  end

  context "player 1 score" do

    it "should be 15 after one point" do
      award_points(player1: 1)

      expect(subject.score).to eq("15 - 0")
    end

    it "should be 30 after two points" do
      award_points(player1: 2)

      expect(subject.score).to eq("30 - 0")
    end

    it "should be 40 after three points" do
      award_points(player1: 3)

      expect(subject.score).to eq("40 - 0")
    end

    it "should be winner after four consequtive points" do
      award_points(player1: 4)

      expect(subject.score).to eq("A winner is Player #1!")
    end

  end

  context "player 2 score" do

    it "should be 15 after one point" do
      award_points(player2: 1)

      expect(subject.score).to eq("0 - 15")
    end

    it "should be 30 after two points" do
      award_points(player2: 2)

      expect(subject.score).to eq("0 - 30")
    end

    it "should be 40 after three points" do
      award_points(player2: 3)

      expect(subject.score).to eq("0 - 40")
    end

    it "should be winner after four consequtive points" do
      award_points(player2: 4)

      expect(subject.score).to eq("A winner is Player #2!")
    end

  end

  context "end game score" do

    it "should be Deuce if tied at 40" do
      award_points(player1: 3, player2: 3)

      expect(subject.score).to eq("Deuce")
    end

    it "should be advantage player 1 if player 1 wins at deuce" do
      award_points(player1: 3, player2: 3)
      award_points(player1: 1)
      expect(subject.score).to eq("Advantage Player #1!")
    end

    it "should be advantage player 2 if player 2 wins at deuce" do
      award_points(player1: 3, player2: 3)
      award_points(player2: 1)
      expect(subject.score).to eq("Advantage Player #2!")
    end

    it "should be winner player 1 if player 1 wins two points at deuce" do
      award_points(player1: 3, player2: 3)
      award_points(player1: 2)
      expect(subject.score).to eq("A winner is Player #1!")
    end

    it "should be winner player 2 if player 2 wins two points at deuce" do
      award_points(player1: 3, player2: 3)
      award_points(player2: 2)
      expect(subject.score).to eq("A winner is Player #2!")
    end

    it "should be deuce if player 1 breaks advantage" do
      award_points(player1: 3, player2: 3)
      award_points(player2: 1)
      award_points(player1: 1)

      expect(subject.score).to eq("Deuce")
    end

    it "should be deuce if player 1 breaks advantage" do
      award_points(player1: 3, player2: 3)
      award_points(player1: 1)
      award_points(player2: 1)

      expect(subject.score).to eq("Deuce")
    end

    it "should be adv. player 1 if player 1 breaks advantage and scores point" do
      award_points(player1: 3, player2: 3)
      award_points(player2: 1)
      award_points(player1: 2)

      expect(subject.score).to eq("Advantage Player #1!")
    end

    it "should be adv. player 2 if player 2 breaks advantage and scores point" do
      award_points(player1: 3, player2: 3)
      award_points(player1: 1)
      award_points(player2: 2)

      expect(subject.score).to eq("Advantage Player #2!")
    end

    it "should be winner player 1 if player 1 wins 3 points at disadvantage" do
      award_points(player1: 3, player2: 3)
      award_points(player2: 1)
      award_points(player1: 3)

      expect(subject.score).to eq("A winner is Player #1!")
    end

    it "should be winner player 2 if player 2 wins 3 points at disadvantage" do
      award_points(player1: 3, player2: 3)
      award_points(player1: 1)
      award_points(player2: 3)

      expect(subject.score).to eq("A winner is Player #2!")
    end

  end

  context "incorrect input" do

    it "should not accept points after match is done" do
      award_points(player1: 4)

      expect {
        subject.award_point_to_player1()
      }.to raise_error(RuntimeError)

      expect {
        subject.award_point_to_player2()
      }.to raise_error(RuntimeError)
    end

  end

end
