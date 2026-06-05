const enableVlcDemo = process.env.RTSPSTREAM_DEMO_VLC === "1";

const config = {
  address: "0.0.0.0",
  port: 8080,
  basePath: "/",
  ipWhitelist: [],
  language: "eo",
  logLevel: ["INFO", "LOG", "WARN", "ERROR", "DEBUG"],
  modules: [
    {
      module: "clock",
      position: "top_left"
    },
    {
      module: "MMM-RTSPStream",
      position: "top_right",
      config: {
        autoStart: true,
        rotateStreams: true,
        rotateStreamTimeout: 10,
        moduleWidth: 354,
        moduleHeight: 240,
        localPlayer: "webrtc",
        remotePlayer: "none",
        showSnapWhenPaused: true,
        remoteSnaps: true,
        shutdownDelay: 12,
        stream1: {
          name: "Test Stream",
          url: "rtsp://127.0.0.1:8554/test",
          whepUrl: "http://localhost:8889/test/whep",
          width: 640,
          height: 480,
          muted: true
        }
      }
    },
    {
      // Optional second instance to validate local RTSP/VLC path in parallel with WebRTC.
      disabled: !enableVlcDemo,
      module: "MMM-RTSPStream",
      position: "bottom_left",
      config: {
        autoStart: true,
        rotateStreams: true,
        rotateStreamTimeout: 10,
        moduleWidth: 354,
        moduleHeight: 240,
        localPlayer: "vlc",
        remotePlayer: "none",
        showSnapWhenPaused: true,
        remoteSnaps: true,
        shutdownDelay: 12,
        stream1: {
          name: "RTSP VLC Test Stream",
          url: "rtsp://127.0.0.1:8554/test",
          width: 640,
          height: 480,
          muted: true
        }
      }
    }
  ]
};

/** ************* DO NOT EDIT THE LINE BELOW ***************/
if (typeof module !== "undefined") {
  module.exports = config;
}
