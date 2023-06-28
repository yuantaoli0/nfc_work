import 'package:sdk/language.dart';
import 'package:sdk/xlocal.dart';

class XLocal extends XBaseLocal {
  final _dict = {
    AppLanguge.en: {
      'punchin': 'Punchin',
      'punchout': 'Punchout',
      'repose': 'Repose',
      'resume': 'Resume',
      'confirm': 'Confirm',
      'cancel': 'Cancel'
    },
    AppLanguge.fr: {
      'punchin': 'Travailler',
      'punchout': 'Quitter',
      'repose': 'Repose',
      'resume': 'Sup',
      'confirm': 'Confirmation',
      'cancel': 'Cancel'
    },
    AppLanguge.zh: {
      'punchin': '上班',
      'punchout': '下班',
      'repose': '休息',
      'resume': '加班',
      'confirm': '确认',
      'cancel': '取消'
    },
    AppLanguge.ko: {
      'punchin': '출근',
      'punchout': '퇴근',
      'repose': '휴식',
      'resume': '초과근무',
      'confirm': '확인',
      'cancel': '취소'
    },
    AppLanguge.ja: {
      'punchin': '仕事へ行',
      'punchout': '仕事を切',
      'repose': '休憩',
      'resume': '残業時間',
      'confirm': '確認事項',
      'cancel': 'キャンセル'
    },
  };
  Map<String, Map<String, String>> get keys => _dict;

  @override
  // TODO: implement name
  String get name => 'option_';

  @override
  String? getTranslation(String key, String languageCode) {
    if (_dict.containsKey(languageCode) &&
        _dict[languageCode]!.containsKey(key)) {
      return _dict[languageCode]![key];
    }
    return null;
  }
}
