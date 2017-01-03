module StatusObject
  class Status
    attr_reader :notice, :user

    def initialize(options = {})
      @success = options[:success]
      @notice = options[:notice]
      @user = options[:user]
    end

    def success?
      @success
    end
  end
end
