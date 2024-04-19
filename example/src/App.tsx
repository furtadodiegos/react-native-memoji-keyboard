import * as React from 'react';

import { Image, StyleSheet, TouchableOpacity, View } from 'react-native';
import { MemojiKeyboardView } from 'react-native-memoji-keyboard';

const noMemoji = Image.resolveAssetSource(require('./noMemoji.png')).uri;

export default function App() {
  const [base64, setBase64] = React.useState('');

  return (
    <View style={styles.container}>
      <TouchableOpacity onPress={() => setBase64('')}>
        <Image source={{ uri: base64 || noMemoji }} width={140} height={140} />
      </TouchableOpacity>

      {!base64 && (
        <MemojiKeyboardView
          onChosen={(e) => {
            setBase64(`data:image/png;base64,${e.nativeEvent.data}`);
          }}
          style={styles.box}
        />
      )}
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  box: {
    flex: 1,
  },
});
