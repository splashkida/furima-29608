require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録'
  context '新規登録がうまく行く時' do
    it "nicknameとemail、passwordとpassword_confirmation、名字、名前、名字カナ、名前カナ、生年月日が存在すれば登録できる" do
      expect(@user).to be_valid
    end
    
    it "passwordが6文字以上であれば登録できる" do
      @user.password = "000000a"
      @user.password_confirmation = "000000a"
      expect(@user).to be_valid
    end

    it "emailが一意性であれば登録できる" do
      @user.save
      another_user = FactoryBot.build(:user)
      another_user.email != @user.email
      expect(@user).to be_valid
    end

    it "emailが@を含むとき登録できる" do
      @user.email = "aaa@gmail.com"
      expect(@user).to be_valid
    end

    it "passwordは確認用を含めて２回入力すれば登録できる" do
      @user.password = "000000a"
      @user.password_confirmation = "000000a"
      expect(@user).to be_valid
    end

    it "名字は全角で入力すれば登録できる" do
      @user.last_name = "佐藤"
      expect(@user).to be_valid
    end

    it "名前は全角で入力すれば登録できる" do
      @user.first_name = "清"
      expect(@user).to be_valid
    end

    it "名字カナは全角で入力すれば登録できる" do
      @user.last_name_kana = "サトウ"
      expect(@user).to be_valid
    end

    it "名前カナは全角で入力すれば登録できる" do
      @user.first_name_kana = "キヨシ"
      expect(@user).to be_valid
    end
    
  end

  context '新規登録がうまくいかない時' do
    it "nicknameが空だと登録できない" do
      @user.nickname = ""
      @user.valid?
      expect(@user.errors.full_messages).to include "Nickname can't be blank"
    end
  
    it "emailが空では登録できない" do
      @user.email = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end
  
    it "重複したemailが存在する場合登録できない" do
      @user.save
      another_user = FactoryBot.build(:user)
      another_user.email = @user.email
      another_user.valid?
      expect(another_user.errors.full_messages).to include("Email has already been taken")
    end

    it "emailは@を含まないと登録できない" do
      @user.email = 'sample.com'
      @user.valid?
      expect(@user.errors.full_messages).to include('Email is invalid')
    end
  
    it "passwordが空だと登録できない" do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end
  
    it "passwordは6文字以上でないと登録できない" do
      @user.password = "00000"
      @user.password_confirmation = "00000"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end

    it "passwordは確認用を含めて２回入力しないと登録できない" do
      @user.password_confirmation = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "名字が空だと登録できない" do
      @user.last_name = ""
      #user = User.new(nickname: "Abe", email: "kkk@gmail.com", password: "00000000", password_confirmation: "00000000", birthday: "2000-02-02", last_name: "", first_name: "太郎", last_name_kana: "アベ", first_name_kana: "タロウ")
      @user.valid?
      #binding.pry
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end
  
    it "名前が空だと登録できない" do
      @user.first_name = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it "名字フリガナが空だと登録できない" do
      @user.last_name_kana = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kana can't be blank")
    end

    it "名前フリガナが空だと登録できない" do
      @user.first_name_kana = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana can't be blank")
    end

    it "名字は全角でないと登録できない" do
      @user.last_name = 'ｱｱｱ'
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name 全角文字を使用してください")
    end

    it "名前は全角でないと登録できない" do
      @user.first_name = 'ｱｱｱ'
      @user.valid?
      expect(@user.errors.full_messages).to include("First name 全角文字を使用してください")
    end

    it "名字のカナは全角カタカナでないと登録できない" do
      @user.last_name_kana = 'aｱ亜'
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kana 全角カタカナを使用してください")
    end

    it "名前のカナは全角カタカナでないと登録できない" do
      @user.first_name_kana = 'aｱ亜'
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana 全角カタカナを使用してください")
    end

    it "birthdayが空だと登録できない" do
      @user.birthday = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Birthday can't be blank")
    end
  end

  


end
