require 'active_support/concern'

module InputModel
  extend ActiveSupport::Concern

  included do
    scope :disabled, -> { where(disabled: true) }
  end

  def self.create
    # ▼▼▼ 入力用のクラスを動的生成 ▼▼▼
    active_model = Class.new do |_klass|
      include ActiveModel::Model
      include ActiveModel::Conversion
      include ActiveModel::AttributeMethods
      include ActiveRecord::Callbacks

      attr_accessor :items

      def initialize(items)
        @items = items
        items.each do |item|
          # アクセッサ定義
          attr_name = "item_#{item.id}"
          singleton_class.class_eval { attr_accessor attr_name }

          # バリデーション定義
          singleton_class.class_eval { validates attr_name, presence: item.presence} if item.presence
          singleton_class.class_eval { validates attr_name, numericality: { only_integer: item.only_integer}} if item.only_integer
          singleton_class.class_eval { validates attr_name, format: { with: Regexp.new(item.format_with)}, allow_blank: true } if item.format_with
        end
      end

      # attributes= の代わり
      def input_attributes=(hash)
        hash.each do |key, value|
          self.send("#{key}=", ERB::Util.html_escape(value))
        end
      end

      # 入力内容を保存
      def save
        ActiveRecord::Base.transaction do
          submit = Submit.create
          self.items.each do |item|
            val = Value.new({submit_id: submit.id, item_id: item.id})
            attr_name = "item_#{item.id}"

            # 入力データの型に合わせてデータ保存
            case item.typ
              when Item::TYP_STING
                val.str = self.send(attr_name)
              when Item::TYP_NUMBER
                val.int = self.send(attr_name)
              when Item::TYP_DATETIME
                val.datetime = self.send(attr_name)
            end
            val.save
          end
        end
      end
    end

    # ▲▲▲ 入力用のクラスを動的生成 ▲▲▲
    Object.const_set(:Input, active_model)
  end
end
