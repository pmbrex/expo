package abi33_0_0.expo.modules.facedetector;

import android.content.Context;

import java.util.Collections;
import java.util.List;

import abi33_0_0.org.unimodules.core.interfaces.InternalModule;
import abi33_0_0.org.unimodules.interfaces.facedetector.FaceDetector;

public class FaceDetectorProvider implements abi33_0_0.org.unimodules.interfaces.facedetector.FaceDetectorProvider, InternalModule {
  @Override
  public List<Class> getExportedInterfaces() {
    return Collections.singletonList((Class) abi33_0_0.org.unimodules.interfaces.facedetector.FaceDetectorProvider.class);
  }

  public FaceDetector createFaceDetectorWithContext(Context context) {
    return new ExpoFaceDetector(context);
  }
}
