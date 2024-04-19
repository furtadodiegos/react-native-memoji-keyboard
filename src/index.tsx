import {
  requireNativeComponent,
  UIManager,
  Platform,
  type ViewStyle,
} from 'react-native';

const LINKING_ERROR =
  `The package 'react-native-memoji-keyboard' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo Go\n';

type MemojiKeyboardProps = {
  onChosen: (event: any) => void;
  style?: ViewStyle;
};

const ComponentName = 'MemojiKeyboardView';

export const MemojiKeyboardView =
  UIManager.getViewManagerConfig(ComponentName) != null
    ? requireNativeComponent<MemojiKeyboardProps>(ComponentName)
    : () => {
        throw new Error(LINKING_ERROR);
      };
