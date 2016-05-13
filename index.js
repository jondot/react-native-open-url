
import { NativeAppEventEmitter, NativeModules } from 'react-native';
// const Manager = NativeModules.JTOpenUrlManager // no need for this for now, communication is one way
//
const EVT_OPEN_URL  = 'openUrlReceived';
let subscribers = new Map()

class OpenUrl{
  static subscribe(handler){
    let listener = subscribers.get(handler)
    if(listener){
      this.unsubscribe(handler)
    }

    listener = NativeAppEventEmitter.addListener(
        EVT_OPEN_URL,
        (data) => {
          handler(data)
        }
      )
    subscribers.set(handler, listener)
  }

  static unsubscribe(handler){
    let listener = subscribers.get(handler)
    if(listener){
      listener.remove()
      subscribers.delete(handler)
    }
  }
}

export default OpenUrl
