class ContactsController < ApplicationController
  def index
    @contacts = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      # ユーザーにメールを送信
      ContactMailer.user_email(@contact).deliver_now
      # 管理者にメールを送信
      ContactMailer.admin_email(@contact).deliver_now
      redirect_to root_path
    else
      render :index
    end
  end

  private

  # IPアドレスをパラメータに追加
  def contact_params
    params.require(:contact)
          .permit(:name, :email, :contact)
          .merge(remote_ip: request.remote_ip)
  end
end
