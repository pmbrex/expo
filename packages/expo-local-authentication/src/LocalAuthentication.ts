import { UnavailabilityError } from '@unimodules/core';
import invariant from 'invariant';
import { Platform } from 'react-native';

import ExpoLocalAuthentication from './ExpoLocalAuthentication';

import { AuthenticationType, LocalAuthenticationResult } from './LocalAuthentication.types';

export { AuthenticationType, LocalAuthenticationResult };

export async function hasHardwareAsync(): Promise<boolean> {
  if (!ExpoLocalAuthentication.hasHardwareAsync) {
    throw new UnavailabilityError('expo-local-authentication', 'hasHardwareAsync');
  }
  return await ExpoLocalAuthentication.hasHardwareAsync();
}

export async function supportedAuthenticationTypesAsync(): Promise<AuthenticationType[]> {
  if (!ExpoLocalAuthentication.supportedAuthenticationTypesAsync) {
    throw new UnavailabilityError('expo-local-authentication', 'supportedAuthenticationTypesAsync');
  }
  return await ExpoLocalAuthentication.supportedAuthenticationTypesAsync();
}

export async function isEnrolledAsync(): Promise<boolean> {
  if (!ExpoLocalAuthentication.isEnrolledAsync) {
    throw new UnavailabilityError('expo-local-authentication', 'isEnrolledAsync');
  }
  return await ExpoLocalAuthentication.isEnrolledAsync();
}

export async function authenticateAsync(
  promptMessageIOS: string = 'Authenticate'
): Promise<LocalAuthenticationResult> {
  if (!ExpoLocalAuthentication.authenticateAsync) {
    throw new UnavailabilityError('expo-local-authentication', 'authenticateAsync');
  }

  if (Platform.OS === 'ios') {
    invariant(
      typeof promptMessageIOS === 'string' && promptMessageIOS.length,
      'LocalAuthentication.authenticateAsync must be called with a non-empty string on iOS'
    );

    const result = await ExpoLocalAuthentication.authenticateAsync(promptMessageIOS);

    if (result.warning) {
      console.warn(result.warning);
    }
    return result;
  } else {
    return await ExpoLocalAuthentication.authenticateAsync();
  }
}

export async function cancelAuthenticate(): Promise<void> {
  if (!ExpoLocalAuthentication.cancelAuthenticate) {
    throw new UnavailabilityError('expo-local-authentication', 'cancelAuthenticate');
  }
  await ExpoLocalAuthentication.cancelAuthenticate();
}
