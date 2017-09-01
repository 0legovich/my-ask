class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
  end

  def edit
  end

  def show
    @user = User.new(
                  name: 'Roman',
                  username: '0legovich',
                  avatar_url: "https://s.gravatar.com/avatar/8713f040e2f15993c425e4d20d78106c?s=100"
    )

    @questions = [
      Question.new(text: 'Как дела?', created_at: Date.parse('31.08.2017')),
      Question.new(text: 'Когда поедем?', created_at: Date.parse('30.08.2017'))
    ]

    @new_question = Question.new
  end
end
