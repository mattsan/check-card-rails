require 'prawn'
require 'prawn/measurement_extensions'

class CheckCard
  class << self
    def render(params)

      name          = params[:name] || ''
      pronouncement = params[:pronouncement] || ''
      gender        = params[:gender] || ''
      grade         = params[:grade] || ''
      zip           = params[:zip] || ''
      address1      = params[:address1] || ''
      address2      = params[:address2] || ''
      phone         = params[:phone] || ''
      classroom     = params[:classroom] || ''
      datetime      = params[:datetime] || ''

      # PDF オブジェクトの生成
      pdf = Prawn::Document.new page_size: 'A4', margin: [15.mm, 16.mm, 21.mm, 9.mm]

      # 日本語フォントの読み込み
      pdf.font('vendor/assets/fonts/ipaexm.ttf')

      # 受付内容欄
      pdf.bounding_box([0.mm, 265.mm], width: 185.mm, height: 129.mm) do

        # 飾り罫
        # 幅の広い斜めの波線を矩形でマスクして飾り罫を実現しています
        pdf.save_graphics_state do
          # マスク部分
          pdf.soft_mask do
            pdf.stroke_color(0, 0, 0, 50)
            pdf.line_width = 2
            pdf.stroke_bounds
            pdf.horizontal_line(0.mm, 185.mm, at: 107.mm)
            pdf.stroke
          end

          # 幅の広い波線
          pdf.stroke_color(20, 0, 50, 0)
          pdf.line_width(700)
          pdf.dash([5, 1, 2, 1])
          pdf.stroke_line([-1.mm, 129.mm], 186.mm, 0.mm)
          pdf.undash
          pdf.stroke_color(0, 0, 0, 100)
        end

        # 表題欄
        pdf.font_size(16)

        pdf.bounding_box([0.mm, 126.mm], width: 185.mm, height: 19.mm) do
          pdf.fill_color([50, 0, 0, 0])
          pdf.text_box('受付内容確認カード', at: [0.mm, 19.mm], width: 185.mm, height: 10.mm, size: 20, align: :center, valign: :center)
          pdf.text_box('教室', at: [16.mm, 9.mm], width: 14.mm, height: 9.mm, align: :center, valign: :center)
          pdf.text_box('体験学習日', at: [95.mm, 9.mm], width: 30.mm, height: 9.mm, align: :center, valign: :center)

          pdf.fill_color([0, 0, 0, 100])
          pdf.text_box('本部', at: [2.mm, 9.mm], width: 14.mm, height: 9.mm, align: :center, valign: :center)
          pdf.text_box(classroom, at: [32.mm, 9.mm], width: 14.mm, height: 9.mm, align: :center, valign: :center)
          pdf.text_box(datetime, at: [120.mm, 9.mm], width: 65.mm, height: 9.mm, size: 14, align: :center, valign: :center)
        end

        pdf.fill_color([50, 0, 0, 0])
        pdf.text_box('番号', at: [153.mm, 105.mm], width: 8.mm, height: 4.mm, size: 9, valign: :center)
        pdf.text_box('【受付内容】', at: [0.mm, 100.mm], width: 181.mm, height: 9.mm, size: 16, align: :center, valign: :center)

        pdf.fill_color([0, 0, 0, 100])
        pdf.text_box('123456789', at: [162.mm, 105.mm], width: 18.mm, height: 4.mm, size: 9, valign: :center)

        # 受講者情報欄
        pdf.bounding_box([2.mm, 77.mm], width: 181.mm, height: 75.mm) do
          # 罫線と枠線
          pdf.line_width = 1
          pdf.dash([1])
          pdf.horizontal_line(0.mm, 181.mm, at: 75.mm)
          pdf.horizontal_line(0.mm, 181.mm, at: 66.mm)
          pdf.horizontal_line(0.mm, 181.mm, at: 57.mm)
          pdf.horizontal_line(0.mm, 181.mm, at: 48.mm)
          pdf.horizontal_line(0.mm, 181.mm, at: 39.mm)
          pdf.rectangle([0.mm, 20.mm], 181.mm, 20.mm)
          pdf.stroke
          pdf.undash

          pdf.fill_color([50, 0, 0, 0])

          # 受講者情報・見出し
          pdf.bounding_box([3.mm, 89.mm], width: 23.mm, height: 50.mm) do
            pdf.text_box('ふ  り  が  な', at: [0.mm, 50.mm], width: 23.mm, height: 5.mm, size: 9, align: :center, valign: :center)
            pdf.text_box('お 名 前', at: [0.mm, 45.mm], width: 23.mm, height: 9.mm, align: :center, valign: :center)
            pdf.text_box('性別', at: [111.mm, 45.mm], width: 14.mm, height: 9.mm, align: :center, valign: :center)
            pdf.text_box('学年', at: [143.mm, 45.mm], width: 14.mm, height: 9.mm, align: :center, valign: :center)
            pdf.text_box('住      所', at: [0.mm, 36.mm], width: 23.mm, height: 9.mm, align: :center, valign: :center)
            pdf.text_box('電話番号', at: [0.mm, 9.mm], width: 23.mm, height: 9.mm, align: :center, valign: :center)
          end

          # 保護者情報・見出し
          pdf.bounding_box([3.mm, 20.mm], width: 23.mm, height: 20.mm) do
            pdf.text_box('ふ  り  が  な', at: [0.mm, 18.mm], width: 23.mm, height: 6.mm, size: 9, align: :center, valign: :center)
            pdf.text_box('保護者氏名', at: [0.mm, 13.mm], width: 23.mm, height: 6.mm, size: 12, align: :center, valign: :center)
            pdf.text_box('（世帯主）', at: [0.mm, 7.mm], width: 23.mm, height: 6.mm, size: 12, align: :center, valign: :center)
          end

          # 受講者情報
          pdf.fill_color([0, 0, 0, 100])

          pdf.bounding_box([30.mm, 89.mm], width: 150.mm, height: 50.mm) do
            pdf.text_box(pronouncement, at: [0.mm, 50.mm], width: 156.mm, height: 5.mm, size: 9, valign: :center)
            pdf.text_box(name, at: [0.mm, 45.mm], width: 156.mm, height: 9.mm, valign: :center)
            pdf.text_box(gender, at: [100.mm, 45.mm], width: 14.mm, height: 9.mm, valign: :center)
            pdf.text_box(grade, at: [130.mm, 45.mm], width: 20.mm, height: 9.mm, valign: :center)
            pdf.text_box("〒 #{zip}", at: [0.mm, 36.mm], width: 156.mm, height: 9.mm, valign: :center)
            pdf.text_box(address1, at: [0.mm, 27.mm], width: 156.mm, height: 9.mm, valign: :center)
            pdf.text_box(address2, at: [0.mm, 18.mm], width: 156.mm, height: 9.mm, valign: :center)
            pdf.text_box(phone, at: [0.mm, 9.mm], width: 156.mm, height: 9.mm, valign: :center)
          end

          # チェック欄
          pdf.font_size(10)
          pdf.bounding_box([4.mm, 39.mm], width: 180.mm, height: 19.mm) do
            pdf.text_box('□ 記載事項に相違がないことを確認しました', at: [0.mm, 14.mm], width: 90.mm, height: 7.mm)
            pdf.text_box('□ 記載事項を上記のとおり訂正しました', at: [95.mm, 14.mm], width: 80.mm, height: 7.mm)
            pdf.text_box('どちらかに □ を記入のうえ、署名をおねがいします。', at: [0.mm, 7.mm], width: 170.mm, height: 7.mm)
            # チェック（利用しているフォントにチェック文字がないため、らいんで実現している）
            pdf.stroke do
              pdf.move_to(19.mm, 5.mm)
              pdf.line_to(20.mm, 4.mm)
              pdf.line_to(22.mm, 7.mm)
            end
          end
        end
      end

      # 入会受付欄

      pdf.font_size(14)
      pdf.text_box('入会受付欄', at: [0.mm, 130.mm], width: 185.mm, height: 14.mm, align: :center, valign: :center)

      # 記入欄
      pdf.bounding_box([0.mm, 116.mm], width: 185.mm, height: 90.mm) do
        # 枠線
        pdf.line_width = 1
        pdf.stroke_bounds

        pdf.horizontal_line(0.mm, 185.mm, at: 37.mm)
        pdf.horizontal_line(0.mm, 185.mm, at: 64.mm)
        pdf.vertical_line(37.mm, 90.mm, at: 92.mm)
        pdf.vertical_line(64.mm, 90.mm, at: 46.mm)
        pdf.vertical_line(64.mm, 90.mm, at: 69.mm)
        pdf.vertical_line(64.mm, 90.mm, at: 115.mm)
        pdf.vertical_line(64.mm, 90.mm, at: 162.mm)
        pdf.stroke

        pdf.line_width = 0.2
        pdf.horizontal_line(0.mm, 185.mm, at: 80.mm)
        pdf.horizontal_line(0.mm, 185.mm, at: 57.mm)
        pdf.horizontal_line(0.mm, 92.mm, at: 47.mm)
        pdf.vertical_line(0.mm, 37.mm, at: 23.mm)
        pdf.stroke

        pdf.dash([2])
        pdf.vertical_line(37.mm, 57.mm, at: 23.mm)
        pdf.ellipse([11.5.mm, 42.mm], 10.mm, 4.mm)
        pdf.ellipse([11.5.mm, 52.mm], 10.mm, 4.mm)
        pdf.ellipse([11.5.mm, 72.mm], 10.mm, 4.mm)
        pdf.ellipse([34.5.mm, 72.mm], 10.mm, 4.mm)
        pdf.ellipse([97.75.mm, 72.mm], 4.mm)
        pdf.ellipse([109.25.mm, 72.mm], 4.mm)
        pdf.stroke
        pdf.undash

        # 説明
        pdf.font_size(9)

        pdf.bounding_box([0.mm, 90.mm], width: 185.mm, height: 90.mm) do
          pdf.text_box('入会希望', at: [0.mm, 90.mm], width: 46.mm, height: 10.mm, align: :center, valign: :center)
          pdf.text_box('入会月', at: [46.mm, 90.mm], width: 23.mm, height: 10.mm, align: :center, valign: :center)
          pdf.text_box('入会クラス', at: [69.mm, 90.mm], width: 23.mm, height: 10.mm, align: :center, valign: :center)
          pdf.text_box('兄弟姉妹 会員の有無', at: [92.mm, 90.mm], width: 23.mm, height: 10.mm, align: :center, valign: :center)
          pdf.text_box('兄弟姉妹会員の名前 （ふりがな）', at: [115.mm, 90.mm], width: 46.mm, height: 10.mm, align: :center, valign: :center)
          pdf.text_box('兄弟姉妹 会員の学年', at: [162.mm, 90.mm], width: 23.mm, height: 10.mm, align: :center, valign: :center)
          pdf.text_box('する', at: [0.mm, 80.mm], width: 23.mm, height: 16.mm, align: :center, valign: :center)
          pdf.text_box('しない', at: [23.mm, 80.mm], width: 23.mm, height: 16.mm, align: :center, valign: :center)
          pdf.text_box('有', at: [92.mm, 80.mm], width: 11.5.mm, height: 16.mm, align: :center, valign: :center)
          pdf.text_box('無', at: [103.5.mm, 80.mm], width: 11.5.mm, height: 16.mm, align: :center, valign: :center)
          pdf.text_box('支払い方法と年会費（初回振込分）詳細', at: [0.mm, 64.mm], width: 92.mm, height: 7.mm, align: :center, valign: :center)
          pdf.text_box('振込予定金額', at: [92.mm, 64.mm], width: 92.mm, height: 7.mm, align: :center, valign: :center)
          pdf.text_box('分割', at: [0.mm, 57.mm], width: 23.mm, height: 10.mm, align: :center, valign: :center)
          pdf.text_box('月分（        月引落開始予定）', at: [43.mm, 57.mm], width: 49.mm, height: 10.mm, align: :left, valign: :center)
          pdf.text_box('一括', at: [0.mm, 47.mm], width: 23.mm, height: 10.mm, align: :center, valign: :center)
          pdf.text_box('月分〜３月分', at: [43.mm, 47.mm], width: 49.mm, height: 10.mm, align: :left, valign: :center)
          pdf.text_box('備考', at: [0.mm, 37.mm], width: 23.mm, height: 37.mm, align: :center, valign: :center)
        end
      end

      # 捺印欄
      pdf.bounding_box([0.mm, 20.mm], width: 138.mm, height: 20.mm) do
        # 罫線
        pdf.line_width = 1
        pdf.stroke_bounds

        pdf.vertical_line(0.mm, 20.mm, at: 23.mm)
        pdf.vertical_line(0.mm, 20.mm, at: 69.mm)
        pdf.stroke

        pdf.line_width = 0.2
        pdf.vertical_line(0.mm, 15.mm, at: 46.mm)
        pdf.vertical_line(0.mm, 15.mm, at: 92.mm)
        pdf.vertical_line(0.mm, 15.mm, at: 115.mm)
        pdf.horizontal_line(0.mm, 138.mm, at: 15.mm)
        pdf.stroke

        # 説明
        pdf.bounding_box([0.mm, 20.mm], width: 138.mm, height: 5.mm) do
          pdf.text_box('受付者', at: [0.mm, 5.mm], width: 23.mm, height: 5.mm, align: :center, valign: :center)
          pdf.text_box('教室欄', at: [23.mm, 5.mm], width: 46.mm, height: 5.mm, align: :center, valign: :center)
          pdf.text_box('本部欄', at: [69.mm, 5.mm], width: 69.mm, height: 5.mm, align: :center, valign: :center)
        end
      end

      # PDF のレンダリング
      pdf.render
    end
  end
end
