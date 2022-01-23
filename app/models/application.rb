class Application < ApplicationRecord
    after_initialize :init
    has_many :chats

    def init
        self.chats_count ||= 0
        self.chats_created ||= 0
    end
end
