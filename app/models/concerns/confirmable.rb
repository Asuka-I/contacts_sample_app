module Confirmable
  extend ActiveSupport::Concern

  included do
    validates :submitted, acceptance: true
    validates :confirmed, acceptance: true

    after_validation :confirming

    private

    def confirming
      # 「送信」ボタンをクリックして，ユーザーの入力にエラーが存在しないとき
      if self.submitted == "" && self.errors.keys == [:submitted]
        self.submitted = "1"
      end
      # 「戻る」ボタンをクリックしたとき
      self.submitted = "" if self.confirmed == ""

      errors.delete :submitted
      errors.delete :confirmed
    end
  end
end