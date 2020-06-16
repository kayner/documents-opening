# frozen_string_literal: true

# Module with static data
module Static
  module Path
    APK_PATH = File.join __dir__,  '..', 'documents.apk'
    ADB_PATH = File.join ENV['ANDROID_HOME'], 'platform-tools', 'adb'
    LOG_PATH = File.join __dir__,  '..', 'log'
    FILES_PATH = File.join __dir__,  '..', 'files'
    SCREENSHOTS_PATH = File.join __dir__,  '..', 'screenshots'
  end
  
  module Id
    ONBOARDING_SKIP = 'on_boarding_panel_skip_button'
    ON_DEVICE_SECTION = 'menu_item_on_device'
    SEARCH_OPEN = 'search_button'
    SEARCH_FIELD = 'search_src_text'
    FILE_NAME = 'list_explorer_file_name'
    EDITORS_SETTINGS = 'toolbarSettingsButton'

    EXPORT_DOCUMENT_BTN = 'docsSettingsItemDownload'
    EXPORT_DOCUMENT_TO_DOCX = 'docsSaveDocx'
    EXPORT_DOCUMENT_TO_PDF = 'docsSavePdf'
    EXPORT_DOCUMENT_TO_RTF = 'docsSaveRtf'
    EXPORT_DOCUMENT_TO_ODT = 'docsSaveOdt'

    EXPORT_SPREADSHEET_BTN = 'cellsSettingsItemDownload'
    EXPORT_SPREADSHEET_TO_XLSX = 'cellsSaveXlsx'
    EXPORT_SPREADSHEET_TO_PDF = 'cellsSavePdf'
    EXPORT_SPREADSHEET_TO_ODS = 'cellsSaveOds'
    EXPORT_SPREADSHEET_TO_CSV = 'cellsSaveCsv'

    EXPORT_PRESENTATION_BTN = 'slidesSettingsItemDownload'
    EXPORT_PRESENTATION_TO_PPTX = 'slidesSavePptx'
    EXPORT_PRESENTATION_TO_PDF = 'slidesSavePdf'
    EXPORT_PRESENTATION_TO_ODP = 'slidesSaveOdp'

    EXPORT_LOADER = 'dialogCommonWaitingProgressBarCircle'
  end
end
