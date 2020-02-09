class Picture < ActiveRecord::Base
    belongs_to :user

    def formatted_created_at
        self.created_at.strftime("%m/%d/%Y")
    end
end
