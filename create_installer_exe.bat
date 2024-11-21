@echo off
echo Creating EXE file...

:: Check if icon exists
if not exist "logo_RyX_icon.ico" (
    echo Error: logo_RyX_icon.ico not found!
    echo Please place the icon file in the same directory as this script.
    pause
    exit /b 1
)

:: Find CSC.exe
set "NET_VERSION=v4.0.30319"
set "CSC_PATH=%SystemRoot%\Microsoft.NET\Framework64\%NET_VERSION%\csc.exe"
if not exist "%CSC_PATH%" (
    set "CSC_PATH=%SystemRoot%\Microsoft.NET\Framework\%NET_VERSION%\csc.exe"
)

if not exist "%CSC_PATH%" (
    echo Error: Could not find C# compiler ^(csc.exe^)
    echo Please install .NET Framework 4.0 or later
    pause
    exit /b 1
)

:: Create a temporary CS file
echo using System; > ModInstaller.cs
echo using System.IO; >> ModInstaller.cs
echo using System.Net; >> ModInstaller.cs
echo using System.IO.Compression; >> ModInstaller.cs
echo using System.Windows.Forms; >> ModInstaller.cs
echo using System.Threading.Tasks; >> ModInstaller.cs
echo using System.Net.Security; >> ModInstaller.cs
echo using System.Security.Cryptography; >> ModInstaller.cs
echo using System.Text; >> ModInstaller.cs
echo using System.Drawing; >> ModInstaller.cs
echo using System.ComponentModel; >> ModInstaller.cs
echo using System.Text.RegularExpressions; >> ModInstaller.cs
echo using System.Drawing.Drawing2D; >> ModInstaller.cs
echo. >> ModInstaller.cs
echo [assembly: System.Reflection.AssemblyTitle("Kizu Server Mod Installer")] >> ModInstaller.cs
echo [assembly: System.Reflection.AssemblyDescription("Official Minecraft Mod Installer for Kizu Server")] >> ModInstaller.cs
echo [assembly: System.Reflection.AssemblyCompany("KizuServer")] >> ModInstaller.cs
echo [assembly: System.Reflection.AssemblyProduct("Kizu Server Mod Installer")] >> ModInstaller.cs
echo [assembly: System.Reflection.AssemblyCopyright("Copyright © 2024 KizuServer")] >> ModInstaller.cs
echo [assembly: System.Reflection.AssemblyVersion("1.0.0.0")] >> ModInstaller.cs
echo [assembly: System.Reflection.AssemblyFileVersion("1.0.0.0")] >> ModInstaller.cs
echo [assembly: System.Reflection.AssemblyInformationalVersion("1.0.0")] >> ModInstaller.cs
echo. >> ModInstaller.cs
echo namespace KizuServer.ModInstaller { >> ModInstaller.cs
echo     public class ModernProgressBar : ProgressBar { >> ModInstaller.cs
echo         public ModernProgressBar() { >> ModInstaller.cs
echo             this.SetStyle(ControlStyles.UserPaint, true); >> ModInstaller.cs
echo         } >> ModInstaller.cs
echo. >> ModInstaller.cs
echo         protected override void OnPaint(PaintEventArgs e) { >> ModInstaller.cs
echo             Rectangle rec = e.ClipRectangle; >> ModInstaller.cs
echo             rec.Width = (int)(rec.Width * ((double)Value / Maximum)) - 4; >> ModInstaller.cs
echo             if (ProgressBarRenderer.IsSupported) >> ModInstaller.cs
echo                 ProgressBarRenderer.DrawHorizontalBar(e.Graphics, e.ClipRectangle); >> ModInstaller.cs
echo             e.Graphics.FillRectangle(new SolidBrush(Color.FromArgb(0, 120, 215)), 2, 2, rec.Width, rec.Height - 4); >> ModInstaller.cs
echo         } >> ModInstaller.cs
echo     } >> ModInstaller.cs
echo. >> ModInstaller.cs
echo     public class ModernButton : Button { >> ModInstaller.cs
echo         public ModernButton() { >> ModInstaller.cs
echo             FlatStyle = FlatStyle.Flat; >> ModInstaller.cs
echo             FlatAppearance.BorderSize = 0; >> ModInstaller.cs
echo             BackColor = Color.FromArgb(0, 120, 215); >> ModInstaller.cs
echo             ForeColor = Color.White; >> ModInstaller.cs
echo             Font = new Font("Segoe UI", 10F, FontStyle.Regular); >> ModInstaller.cs
echo             Cursor = Cursors.Hand; >> ModInstaller.cs
echo         } >> ModInstaller.cs
echo     } >> ModInstaller.cs
echo. >> ModInstaller.cs
echo     public class Program { >> ModInstaller.cs
echo         private static ModernProgressBar progressBar; >> ModInstaller.cs
echo         private static Label statusLabel; >> ModInstaller.cs
echo         private static Form form; >> ModInstaller.cs
echo         private static Point lastPoint; >> ModInstaller.cs
echo         private const string API_URL = "https://stats-mod-backend.vercel.app/api/modpack"; >> ModInstaller.cs
echo. >> ModInstaller.cs
echo         [STAThread] >> ModInstaller.cs
echo         public static void Main() { >> ModInstaller.cs
echo             ServicePointManager.SecurityProtocol = (SecurityProtocolType)3072; >> ModInstaller.cs
echo             Application.EnableVisualStyles(); >> ModInstaller.cs
echo             Application.SetCompatibleTextRenderingDefault(false); >> ModInstaller.cs
echo             CreateForm(); >> ModInstaller.cs
echo             Application.Run(form); >> ModInstaller.cs
echo         } >> ModInstaller.cs
echo. >> ModInstaller.cs
echo         private static void CreateForm() { >> ModInstaller.cs
echo             form = new Form(); >> ModInstaller.cs
echo             form.Text = "Kizu Server Mod Installer"; >> ModInstaller.cs
echo             form.Width = 500; >> ModInstaller.cs
echo             form.Height = 300; >> ModInstaller.cs
echo             form.StartPosition = FormStartPosition.CenterScreen; >> ModInstaller.cs
echo             form.FormBorderStyle = FormBorderStyle.None; >> ModInstaller.cs
echo             form.BackColor = Color.FromArgb(27, 27, 27); >> ModInstaller.cs
echo. >> ModInstaller.cs
echo             // Title bar >> ModInstaller.cs
echo             Panel titleBar = new Panel(); >> ModInstaller.cs
echo             titleBar.Dock = DockStyle.Top; >> ModInstaller.cs
echo             titleBar.Height = 30; >> ModInstaller.cs
echo             titleBar.BackColor = Color.FromArgb(45, 45, 48); >> ModInstaller.cs
echo. >> ModInstaller.cs
echo             Label titleLabel = new Label(); >> ModInstaller.cs
echo             titleLabel.Text = "Kizu Server Mod Installer"; >> ModInstaller.cs
echo             titleLabel.ForeColor = Color.White; >> ModInstaller.cs
echo             titleLabel.Font = new Font("Segoe UI", 10F, FontStyle.Regular); >> ModInstaller.cs
echo             titleLabel.Location = new Point(10, 7); >> ModInstaller.cs
echo             titleBar.Controls.Add(titleLabel); >> ModInstaller.cs
echo. >> ModInstaller.cs
echo             Button closeButton = new Button(); >> ModInstaller.cs
echo             closeButton.Text = "×"; >> ModInstaller.cs
echo             closeButton.Size = new Size(30, 30); >> ModInstaller.cs
echo             closeButton.Location = new Point(form.Width - 30, 0); >> ModInstaller.cs
echo             closeButton.FlatStyle = FlatStyle.Flat; >> ModInstaller.cs
echo             closeButton.FlatAppearance.BorderSize = 0; >> ModInstaller.cs
echo             closeButton.BackColor = Color.FromArgb(45, 45, 48); >> ModInstaller.cs
echo             closeButton.ForeColor = Color.White; >> ModInstaller.cs
echo             closeButton.Font = new Font("Arial", 15F); >> ModInstaller.cs
echo             closeButton.Cursor = Cursors.Hand; >> ModInstaller.cs
echo             closeButton.Click += new EventHandler(CloseButton_Click); >> ModInstaller.cs
echo             titleBar.Controls.Add(closeButton); >> ModInstaller.cs
echo. >> ModInstaller.cs
echo             // Make form draggable >> ModInstaller.cs
echo             lastPoint = new Point(); >> ModInstaller.cs
echo             titleBar.MouseDown += new MouseEventHandler(TitleBar_MouseDown); >> ModInstaller.cs
echo             titleBar.MouseMove += new MouseEventHandler(TitleBar_MouseMove); >> ModInstaller.cs
echo. >> ModInstaller.cs
echo             statusLabel = new Label(); >> ModInstaller.cs
echo             statusLabel.Text = "Ready to install..."; >> ModInstaller.cs
echo             statusLabel.ForeColor = Color.White; >> ModInstaller.cs
echo             statusLabel.Font = new Font("Segoe UI", 10F); >> ModInstaller.cs
echo             statusLabel.AutoSize = true; >> ModInstaller.cs
echo             statusLabel.Location = new Point(50, 100); >> ModInstaller.cs
echo. >> ModInstaller.cs
echo             progressBar = new ModernProgressBar(); >> ModInstaller.cs
echo             progressBar.Width = 400; >> ModInstaller.cs
echo             progressBar.Height = 5; >> ModInstaller.cs
echo             progressBar.Location = new Point(50, 150); >> ModInstaller.cs
echo             progressBar.BackColor = Color.FromArgb(35, 35, 35); >> ModInstaller.cs
echo. >> ModInstaller.cs
echo             ModernButton installButton = new ModernButton(); >> ModInstaller.cs
echo             installButton.Text = "Install"; >> ModInstaller.cs
echo             installButton.Width = 150; >> ModInstaller.cs
echo             installButton.Height = 40; >> ModInstaller.cs
echo             installButton.Location = new Point((form.Width - 150) / 2, 200); >> ModInstaller.cs
echo             installButton.Click += new EventHandler(InstallButton_Click); >> ModInstaller.cs
echo. >> ModInstaller.cs
echo             form.Controls.AddRange(new Control[] { titleBar, statusLabel, progressBar, installButton }); >> ModInstaller.cs
echo         } >> ModInstaller.cs
echo. >> ModInstaller.cs
echo         private static void InstallButton_Click(object sender, EventArgs e) { >> ModInstaller.cs
echo             Button button = (Button)sender; >> ModInstaller.cs
echo             button.Enabled = false; >> ModInstaller.cs
echo             InstallModpack(); >> ModInstaller.cs
echo         } >> ModInstaller.cs
echo. >> ModInstaller.cs
echo         private static string ExtractUrlFromJson(string json) { >> ModInstaller.cs
echo             Match match = Regex.Match(json, @"""url"":""([^""]+)"""); >> ModInstaller.cs
echo             if (match.Success) { >> ModInstaller.cs
echo                 return match.Groups[1].Value; >> ModInstaller.cs
echo             } >> ModInstaller.cs
echo             throw new Exception("Could not find URL in API response"); >> ModInstaller.cs
echo         } >> ModInstaller.cs
echo. >> ModInstaller.cs
echo         private static void InstallModpack() { >> ModInstaller.cs
echo             string minecraftPath = Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData), ".minecraft\\versions\\kizu-server-1.21.1"); >> ModInstaller.cs
echo             string tempZip = Path.Combine(Path.GetTempPath(), "kizu_mod_temp.zip"); >> ModInstaller.cs
echo. >> ModInstaller.cs
echo             try { >> ModInstaller.cs
echo                 // Get download URL from API >> ModInstaller.cs
echo                 string downloadUrl; >> ModInstaller.cs
echo                 using (WebClient client = new WebClient()) { >> ModInstaller.cs
echo                     client.Headers.Add("User-Agent", "KizuServer Mod Installer/1.0"); >> ModInstaller.cs
echo                     string json = client.DownloadString(API_URL); >> ModInstaller.cs
echo                     downloadUrl = ExtractUrlFromJson(json); >> ModInstaller.cs
echo                 } >> ModInstaller.cs
echo. >> ModInstaller.cs
echo                 if (Directory.Exists(minecraftPath)) { >> ModInstaller.cs
echo                     Directory.Delete(minecraftPath, true); >> ModInstaller.cs
echo                 } >> ModInstaller.cs
echo                 Directory.CreateDirectory(minecraftPath); >> ModInstaller.cs
echo. >> ModInstaller.cs
echo                 using (WebClient client = new WebClient()) { >> ModInstaller.cs
echo                     client.Headers.Add("User-Agent", "KizuServer Mod Installer/1.0"); >> ModInstaller.cs
echo                     statusLabel.Text = "Downloading modpack..."; >> ModInstaller.cs
echo                     client.DownloadProgressChanged += new DownloadProgressChangedEventHandler(DownloadProgressCallback); >> ModInstaller.cs
echo                     client.DownloadFileCompleted += new AsyncCompletedEventHandler(DownloadCompleted); >> ModInstaller.cs
echo                     client.DownloadFileAsync(new Uri(downloadUrl), tempZip); >> ModInstaller.cs
echo                 } >> ModInstaller.cs
echo             } catch (Exception ex) { >> ModInstaller.cs
echo                 MessageBox.Show("Installation error: " + ex.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error); >> ModInstaller.cs
echo                 statusLabel.Text = "Installation failed."; >> ModInstaller.cs
echo                 progressBar.Value = 0; >> ModInstaller.cs
echo             } >> ModInstaller.cs
echo         } >> ModInstaller.cs
echo. >> ModInstaller.cs
echo         private static void DownloadProgressCallback(object sender, DownloadProgressChangedEventArgs e) { >> ModInstaller.cs
echo             progressBar.Value = e.ProgressPercentage; >> ModInstaller.cs
echo             statusLabel.Text = string.Format("Downloading: {0}%%", e.ProgressPercentage); >> ModInstaller.cs
echo         } >> ModInstaller.cs
echo. >> ModInstaller.cs
echo         private static void DownloadCompleted(object sender, AsyncCompletedEventArgs e) { >> ModInstaller.cs
echo             if (e.Error != null) { >> ModInstaller.cs
echo                 ShowError("Download error: " + e.Error.Message); >> ModInstaller.cs
echo                 return; >> ModInstaller.cs
echo             } >> ModInstaller.cs
echo             ProcessInstallation(); >> ModInstaller.cs
echo         } >> ModInstaller.cs
echo. >> ModInstaller.cs
echo         private static void ProcessInstallation() { >> ModInstaller.cs
echo             try { >> ModInstaller.cs
echo                 string minecraftPath = Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData), ".minecraft\\versions\\kizu-server-1.21.1"); >> ModInstaller.cs
echo                 string tempZip = Path.Combine(Path.GetTempPath(), "kizu_mod_temp.zip"); >> ModInstaller.cs
echo. >> ModInstaller.cs
echo                 statusLabel.Text = "Extracting files..."; >> ModInstaller.cs
echo                 ZipFile.ExtractToDirectory(tempZip, minecraftPath); >> ModInstaller.cs
echo. >> ModInstaller.cs
echo                 if (File.Exists(tempZip)) { >> ModInstaller.cs
echo                     File.Delete(tempZip); >> ModInstaller.cs
echo                 } >> ModInstaller.cs
echo. >> ModInstaller.cs
echo                 progressBar.Value = 100; >> ModInstaller.cs
echo                 statusLabel.Text = "Installation completed!"; >> ModInstaller.cs
echo                 ShowCompletionScreen(); >> ModInstaller.cs
echo             } catch (Exception ex) { >> ModInstaller.cs
echo                 ShowError("Extraction error: " + ex.Message); >> ModInstaller.cs
echo             } >> ModInstaller.cs
echo         } >> ModInstaller.cs
echo. >> ModInstaller.cs
echo         private static void ShowCompletionScreen() { >> ModInstaller.cs
echo             foreach (Control control in form.Controls) { >> ModInstaller.cs
echo                 if (control is ModernButton) { >> ModInstaller.cs
echo                     control.Visible = false; >> ModInstaller.cs
echo                 } >> ModInstaller.cs
echo             } >> ModInstaller.cs
echo             progressBar.Visible = false; >> ModInstaller.cs
echo. >> ModInstaller.cs
echo             // Load and display tutorial image >> ModInstaller.cs
echo             try { >> ModInstaller.cs
echo                 if (File.Exists("tutor.png")) { >> ModInstaller.cs
echo                     using (var image = Image.FromFile("tutor.png")) { >> ModInstaller.cs
echo                         PictureBox pictureBox = new PictureBox(); >> ModInstaller.cs
echo                         pictureBox.Image = new Bitmap(image); >> ModInstaller.cs
echo                         pictureBox.SizeMode = PictureBoxSizeMode.Zoom; >> ModInstaller.cs
echo                         pictureBox.Width = 400; >> ModInstaller.cs
echo                         pictureBox.Height = 150; >> ModInstaller.cs
echo                         pictureBox.Location = new Point(50, 40); >> ModInstaller.cs
echo                         pictureBox.BackColor = Color.Transparent; >> ModInstaller.cs
echo                         form.Controls.Add(pictureBox); >> ModInstaller.cs
echo                         pictureBox.BringToFront(); >> ModInstaller.cs
echo                     } >> ModInstaller.cs
echo                 } >> ModInstaller.cs
echo             } catch (Exception ex) { >> ModInstaller.cs
echo                 // If image loading fails, just continue without showing it >> ModInstaller.cs
echo                 System.Diagnostics.Debug.WriteLine("Error loading tutorial image: " + ex.Message); >> ModInstaller.cs
echo             } >> ModInstaller.cs
echo. >> ModInstaller.cs
echo             ModernButton playButton = new ModernButton(); >> ModInstaller.cs
echo             playButton.Text = "Play TLauncher"; >> ModInstaller.cs
echo             playButton.Width = 150; >> ModInstaller.cs
echo             playButton.Height = 40; >> ModInstaller.cs
echo             playButton.Location = new Point((form.Width - 150) / 2, 200); >> ModInstaller.cs
echo             playButton.Click += new EventHandler(PlayButton_Click); >> ModInstaller.cs
echo             form.Controls.Add(playButton); >> ModInstaller.cs
echo             playButton.BringToFront(); >> ModInstaller.cs
echo         } >> ModInstaller.cs
echo. >> ModInstaller.cs
echo         private static void ShowError(string message) { >> ModInstaller.cs
echo             MessageBox.Show(message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error); >> ModInstaller.cs
echo             statusLabel.Text = "Installation failed."; >> ModInstaller.cs
echo             progressBar.Value = 0; >> ModInstaller.cs
echo         } >> ModInstaller.cs
echo. >> ModInstaller.cs
echo         private static void PlayButton_Click(object sender, EventArgs e) { >> ModInstaller.cs
echo             try { >> ModInstaller.cs
echo                 // Flush DNS first >> ModInstaller.cs
echo                 System.Diagnostics.Process process = new System.Diagnostics.Process(); >> ModInstaller.cs
echo                 process.StartInfo.FileName = "ipconfig"; >> ModInstaller.cs
echo                 process.StartInfo.Arguments = "/flushdns"; >> ModInstaller.cs
echo                 process.StartInfo.UseShellExecute = false; >> ModInstaller.cs
echo                 process.StartInfo.CreateNoWindow = true; >> ModInstaller.cs
echo                 process.Start(); >> ModInstaller.cs
echo                 process.WaitForExit(); >> ModInstaller.cs
echo. >> ModInstaller.cs
echo                 string username = Environment.UserName; >> ModInstaller.cs
echo                 string tlauncherPath = Path.Combine("C:\\Users", username, "AppData\\Roaming\\.minecraft\\TLauncher.exe"); >> ModInstaller.cs
echo                 if (File.Exists(tlauncherPath)) { >> ModInstaller.cs
echo                     System.Diagnostics.Process.Start(tlauncherPath); >> ModInstaller.cs
echo                     Application.Exit(); >> ModInstaller.cs
echo                 } else { >> ModInstaller.cs
echo                     MessageBox.Show("TLauncher not found at: " + tlauncherPath, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error); >> ModInstaller.cs
echo                 } >> ModInstaller.cs
echo             } catch (Exception ex) { >> ModInstaller.cs
echo                 MessageBox.Show("Error launching TLauncher: " + ex.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error); >> ModInstaller.cs
echo             } >> ModInstaller.cs
echo         } >> ModInstaller.cs
echo. >> ModInstaller.cs
echo         private static void CloseButton_Click(object sender, EventArgs e) { >> ModInstaller.cs
echo             Application.Exit(); >> ModInstaller.cs
echo         } >> ModInstaller.cs
echo. >> ModInstaller.cs
echo         private static void TitleBar_MouseDown(object sender, MouseEventArgs e) { >> ModInstaller.cs
echo             lastPoint = new Point(e.X, e.Y); >> ModInstaller.cs
echo         } >> ModInstaller.cs
echo. >> ModInstaller.cs
echo         private static void TitleBar_MouseMove(object sender, MouseEventArgs e) { >> ModInstaller.cs
echo             if (e.Button == MouseButtons.Left) { >> ModInstaller.cs
echo                 form.Left += e.X - lastPoint.X; >> ModInstaller.cs
echo                 form.Top += e.Y - lastPoint.Y; >> ModInstaller.cs
echo             } >> ModInstaller.cs
echo         } >> ModInstaller.cs
echo     } >> ModInstaller.cs
echo } >> ModInstaller.cs

:: Compile with additional reference and icon
echo Compiling...
"%CSC_PATH%" /target:winexe /optimize+ /debug- /platform:anycpu /win32icon:logo_RyX_icon.ico /out:ModInstaller.exe /reference:System.Windows.Forms.dll,System.IO.Compression.dll,System.IO.Compression.FileSystem.dll,System.Net.Http.dll,System.Drawing.dll,System.dll ModInstaller.cs

:: Clean up
del ModInstaller.cs

echo.
if exist ModInstaller.exe (
    echo ModInstaller.exe created successfully!
) else (
    echo Failed to create ModInstaller.exe
)
pause 