class MainStoreEvent<T> {
  static const CONNECTED = 'CONNECTED';

  static const PUBLIC_CHAT = 'PUBLIC_CHAT';
  static const PUBLIC_EVENT = 'PUBLIC_EVENT';
  static const PRIVATE_CHAT = 'PRIVATE_CHAT';

  static const MORNING_START = 'MORNING_START';
  static const MORNING_OVER = 'MORNING_OVER';

  static const NIGHT_START = 'NIGHT_START';
  static const NIGHT_OVER = 'NIGHT_OVER';

  static const VOTE_START = 'VOTE_START';
  static const VOTE_OVER = 'VOTE_OVER';

  static const TRIAL_START = 'TRIAL_START';
  static const TRIAL_OVER = 'TRIAL_OVER';

  String event;
  T message;

  MainStoreEvent(this.event, [this.message]);
}
