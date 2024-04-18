class UserPresenter 
    def initialize(user)
        @user = user
    end

    def diplay_user 
        "#{@user.name} (#{@user.email})"
    end
end