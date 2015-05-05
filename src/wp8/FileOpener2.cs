using System;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using Microsoft.Phone.Controls;
using System.Windows.Controls.Primitives;
using System.Windows.Media;
using Windows.Storage;
using System.Diagnostics;
using System.IO;

namespace WPCordovaClassLib.Cordova.Commands
{
    public class FileOpener2 : BaseCommand
    {

        public async void open(string options)
        {
            string[] args = JSON.JsonHelper.Deserialize<string[]>(options);

            string aliasCurrentCommandCallbackId = args[2];

            try
            {
                // Get the file.
                StorageFile file = await Windows.Storage.StorageFile.GetFileFromPathAsync(args[0]);

                // Launch the bug query file.
                await Windows.System.Launcher.LaunchFileAsync(file);

                DispatchCommandResult(new PluginResult(PluginResult.Status.OK), aliasCurrentCommandCallbackId);
            }
            catch (FileNotFoundException)
            {
                DispatchCommandResult(new PluginResult(PluginResult.Status.IO_EXCEPTION), aliasCurrentCommandCallbackId);
            }
            catch (Exception)
            {
                DispatchCommandResult(new PluginResult(PluginResult.Status.ERROR), aliasCurrentCommandCallbackId);
            }
        }
    }
}