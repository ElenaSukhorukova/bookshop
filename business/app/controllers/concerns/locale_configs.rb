module LocaleConfigs
  extend ActiveSupport::Concern

  included do
    private

    def find_out_locale
      header = request.env['HTTP_ACCEPT_LANGUAGE']

      return if header.blank?

      q_factors = find_out_q_factor(header)

      return if q_factors.blank?

      q_factors.sort_by { |lang_pair| -lang_pair[1] }.each do |lang_pair|
        return lang_pair[0] if I18n.available_locales.include?(lang_pair[0].to_sym)
      end

      nil
    end

    def find_out_q_factor(header)
      header.split(',').map do |lan|
        pair = lan.split(';')

        language = pair[0][0, 2]
        factor = pair[1]&.tr('q=', '')&.to_f

        next if factor.blank?

        [language, factor]
      end.compact
    end
  end
end
