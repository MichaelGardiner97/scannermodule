using ReactNative.Bridge;
using System;
using System.Collections.Generic;
using Windows.ApplicationModel.Core;
using Windows.UI.Core;

namespace Scanner.Module.RNScannerModule
{
    /// <summary>
    /// A module that allows JS to share data.
    /// </summary>
    class RNScannerModuleModule : NativeModuleBase
    {
        /// <summary>
        /// Instantiates the <see cref="RNScannerModuleModule"/>.
        /// </summary>
        internal RNScannerModuleModule()
        {

        }

        /// <summary>
        /// The name of the native module.
        /// </summary>
        public override string Name
        {
            get
            {
                return "RNScannerModule";
            }
        }
    }
}
