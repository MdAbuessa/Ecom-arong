import 'package:aarongonzales01/features/user/profile/widgets/setting_body.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen>
    with TickerProviderStateMixin {
  // ── Expand flags ────────────────────────────────────────────────────────────
  bool _accountExpanded = false;
  bool _appExpanded = false;
  bool _dataExpanded = false;
  bool _notifExpanded = false;

  // ── Notification toggles ────────────────────────────────────────────────────
  bool _pushNotifEnabled = true;
  bool _emailNotifEnabled = false;

  // ── App settings ────────────────────────────────────────────────────────────
  int _dailyStepGoal = 6000;

  // ── Animation controllers ────────────────────────────────────────────────────
  late final AnimationController _accountCtrl;
  late final AnimationController _appCtrl;
  late final AnimationController _dataCtrl;
  late final AnimationController _notifCtrl;
  late final Animation<double> _accountAnim;
  late final Animation<double> _appAnim;
  late final Animation<double> _dataAnim;
  late final Animation<double> _notifAnim;

  AnimationController _ctrl() => AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 260),
  );

  Animation<double> _anim(AnimationController c) =>
      CurvedAnimation(parent: c, curve: Curves.easeInOut);

  @override
  void initState() {
    super.initState();
    _accountCtrl = _ctrl();
    _appCtrl = _ctrl();
    _dataCtrl = _ctrl();
    _notifCtrl = _ctrl();
    _accountAnim = _anim(_accountCtrl);
    _appAnim = _anim(_appCtrl);
    _dataAnim = _anim(_dataCtrl);
    _notifAnim = _anim(_notifCtrl);
  }

  @override
  void dispose() {
    _accountCtrl.dispose();
    _appCtrl.dispose();
    _dataCtrl.dispose();
    _notifCtrl.dispose();
    super.dispose();
  }

  void _toggle(
    bool current,
    void Function(bool) setter,
    AnimationController ctrl,
  ) {
    setter(!current);
    !current ? ctrl.forward() : ctrl.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF061115),
      body: SafeArea(
        child: SettingBody(
          accountExpanded: _accountExpanded,
          appExpanded: _appExpanded,
          dataExpanded: _dataExpanded,
          notifExpanded: _notifExpanded,
          accountAnimation: _accountAnim,
          appAnimation: _appAnim,
          dataAnimation: _dataAnim,
          notifAnimation: _notifAnim,
          onToggleAccount: () => _toggle(
            _accountExpanded,
            (v) => setState(() => _accountExpanded = v),
            _accountCtrl,
          ),
          onToggleApp: () => _toggle(
            _appExpanded,
            (v) => setState(() => _appExpanded = v),
            _appCtrl,
          ),
          onToggleData: () => _toggle(
            _dataExpanded,
            (v) => setState(() => _dataExpanded = v),
            _dataCtrl,
          ),
          onToggleNotif: () => _toggle(
            _notifExpanded,
            (v) => setState(() => _notifExpanded = v),
            _notifCtrl,
          ),
          pushNotifEnabled: _pushNotifEnabled,
          emailNotifEnabled: _emailNotifEnabled,
          onPushChanged: (v) => setState(() => _pushNotifEnabled = v),
          onEmailChanged: (v) => setState(() => _emailNotifEnabled = v),
          dailyStepGoal: _dailyStepGoal,
          onDailyStepGoalChanged: (v) => setState(() => _dailyStepGoal = v),
        ),
      ),
    );
  }
}
