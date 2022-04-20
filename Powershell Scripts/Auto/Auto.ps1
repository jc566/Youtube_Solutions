<#
.Synopsis 

.Description

.Notes
 Version 0.0.0.1 - Cleaned up code + Reading Configs from Config File
 Version 0.0.0.2 

#>
#global variables

#region Convert to and from Hashtable
function ConvertPSObjectToHashtable
{
    param (
    [Parameter(ValueFromPipeline)]
    $InputObject
    )

    process
    {
    
        if ($InputObject -is [System.Collections.IEnumerable] -and $InputObject -isnot [string])
        {
            $collection = @(
            foreach ($object in $InputObject) { ConvertPSObjectToHashtable $object }
            )

            Write-Output -NoEnumerate $collection
        }
        elseif ($InputObject -is [psobject])
        {
            $hash = @{}

            foreach ($property in $InputObject.PSObject.Properties)
            {
                $hash[$property.Name] = ConvertPSObjectToHashtable $property.Value
            }

            $hash
        }
        else
        {
            $InputObject
        }
    }
}

#endregion

#region Read from config file
#Reads from Configs.json file and creates a object then returns it
#$ScriptRootPath = $PSScriptRoot
$ConfigPath = resolve-path -path "Configs.json"
#$ConfigPath = "$ScriptRootPath\Configs.json"
$Configs = Get-Content -Raw -Path $ConfigPath | ConvertFrom-Json 
#endregion

Add-Type -AssemblyName WindowsBase,System.Windows.Forms

#region Set Default App Settings

$TimeInterval = $Configs.DefaultTimeInterval
#mainform
$MainWidth = $Configs.MainWidth
$MainHeight = $Configs.MainHeight
$MainFontColor = $Configs.MainFontColor
$TransparencyFilterColor = $Configs.TransparencyFilterColor
#panel
$PanelBackgroundColor = $Configs.PanelBackgroundColor
$PanelFontColor = $Configs.PanelFontColor
$PanelWidth = $Configs.PanelWidth
$PanelHeight = $Configs.PanelHeight
#endregion

#region GUI

    #region create gui form
    $mainform = new-object System.Windows.Forms.Form
    $mainform.Text = "Helper"
    $mainform.Width = $MainWidth
    $mainform.Height = $MainHeight
    $mainform.ForeColor = [System.Drawing.Color]::$MainFontColor
    $mainform.BackColor = [System.Drawing.Color]::$TransparencyFilterColor #[System.Drawing.Color]::Transparent
    $mainform.TransparencyKey = [System.Drawing.Color]::$TransparencyFilterColor 
    #endregion

    #region Create Panels
    $panel = new-object System.Windows.Forms.Panel
    $panel.Text = "Inputs"
    $panel.width = $PanelWidth 
    $panel.height = $PanelHeight
    $panel.BackColor =[System.Drawing.Color]::$PanelBackgroundColor
    $panel.AutoScroll = $true
    $panel.location = new-object system.drawing.point(0,0)
    $panel.SendToBack()
    $mainform.controls.add($panel)
    #endregion

    #region Single Mode
    $singleMode = new-object System.Windows.Forms.Button
    $singleMode.location = new-object System.Drawing.point(0,1)
    $singleMode.Text = "Single"
    $singleMode.AutoSize = $true
    $singleMode.BackColor = "gray"
    $panel.Controls.add($singleMode)
    #endregion

    #region Multi Mode
    $multiMode = new-object System.Windows.Forms.Button
    $multiMode.location = new-object System.Drawing.point(100,1)
    $multiMode.Text = "Multi"
    $multiMode.BackColor = "white"
    $multiMode.AutoSize = $true
    $panel.Controls.add($multiMode)
    #endregion

    
    #region Create Labels for Mouse X/Y positions
    $labelx = new-object System.Windows.Forms.Label
    $labelx.text = "X Position"
    $labelx.location = New-Object System.Drawing.point(0,30)
    $labelx.autosize = $true
    $panel.controls.add($labelx)

    $labely = new-object System.Windows.Forms.Label
    $labely.text = "Y Position"
    $labely.location = New-Object System.Drawing.point(100,30)
    $labely.autosize = $true
    $panel.controls.add($labely)

    $x = new-object System.Windows.Forms.Label
    $x.ForeColor = [System.Drawing.Color]::$PanelFontColor
    $x.location = New-Object System.Drawing.point(0,50)
    $x.autosize = $true
    $panel.controls.add($x)

    $y = new-object System.Windows.Forms.Label
    $y.ForeColor = [System.Drawing.Color]::$PanelFontColor
    $y.location = New-Object System.Drawing.point(100,50)
    $y.autosize = $true
    $panel.controls.add($y)
    #endregion

    #region Take input for x/y mouse pointer to auto
    $inputlabelx = new-object System.Windows.Forms.Label
    $inputlabelx.text = "Target X"
    $inputlabelx.location = New-Object System.Drawing.Point(0,80)
    $inputlabelx.autosize = $true
    $panel.Controls.add($inputlabelx)

    $inputx = new-object System.Windows.Forms.TextBox
    $inputx.Text = 0
    $inputx.location = new-object System.Drawing.point(0,110)
    $inputx.AutoSize = $true
    $panel.Controls.Add($inputx)

    $inputlabely = new-object System.Windows.Forms.Label
    $inputlabely.text = "Target Y"
    $inputlabely.location = New-Object System.Drawing.Point(100,80)
    $inputlabely.autosize = $true
    $panel.Controls.add($inputlabely)

    $inputy = new-object System.Windows.Forms.TextBox
    $inputy.text = 0
    $inputy.location = new-object System.Drawing.point(100,110)
    $inputy.AutoSize = $true
    $panel.Controls.Add($inputy)
    #endregion

    #region Input for intervals between clicks
    $IntervalLabel = new-object System.Windows.Forms.Label
    $IntervalLabel.location = New-Object System.Drawing.Point(0,140)
    $IntervalLabel.text = "Time Interval(Seconds)"
    $IntervalLabel.autosize = $true
    $panel.Controls.add($IntervalLabel)

    $IntervalTextbox = new-object System.Windows.Forms.TextBox
    $IntervalTextbox.text = $TimeInterval
    $IntervalTextbox.location = new-object System.Drawing.point(0,170)
    $IntervalTextbox.AutoSize = $true
    $panel.Controls.Add($IntervalTextbox)
    #endregion

    #region Buttons
    $triggerbutton = new-object System.Windows.Forms.Button
    $triggerbutton.location = new-object System.Drawing.point(0,200)
    $triggerbutton.Text = "start"
    $triggerbutton.AutoSize = $true
    $triggerbutton.BackColor = "white"
    $panel.Controls.Add($triggerbutton)

    $stopbutton = new-object System.Windows.Forms.Button
    $stopbutton.location = new-object System.Drawing.point(100,200)
    $stopbutton.Text = "stop"
    $stopbutton.AutoSize = $true
    $stopbutton.BackColor = "white"
    $panel.Controls.add($stopbutton)


    $addNewToSequence = new-object System.Windows.Forms.Button
    $addNewToSequence.location = new-object System.Drawing.point(0,230)
    $addNewToSequence.Text = "Add New to Sequence"
    $addNewToSequence.BackColor = "white"
    $addNewToSequence.AutoSize = $true
    #$panel.Controls.add($addNewToSequence)


    #endregion



#endregion

#region Tracking Current Position of Mouse
#These events are happening very very frequently to have the most accurate tracking of the mouse cursor
$timer = new-object System.Windows.Threading.DispatcherTimer
#$timer | Get-member
$timer.Interval = [TimeSpan]'0:0:0:00001'
$timer.Add_Tick({
$mouse = [system.windows.forms.cursor]::position
$x.Text = $mouse.X
$y.Text = $mouse.Y
#write-host " THread name :::: $($timer.Dispatcher.Thread.Name)"
})
$timer.Start()
#endregion 

#region GoToLocation 
function GoToLocation
{
    [system.Windows.Forms.Cursor]::Position = "$($inputx.Text),$($inputy.Text)"
}
#endregion

#region Click Left Mouse
function Click-LeftMouseButton
{
    #https://social.technet.microsoft.com/Forums/ie/en-US/48f12259-213c-43a5-99fa-5814928b0145/mouse-click?forum=winserverpowershell
    #https://docs.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-mouse_event
    $signature=@'
    [DllImport("user32.dll",CharSet=CharSet.Auto, CallingConvention=CallingConvention.StdCall)]
    public static extern void mouse_event(long dwFlags, long dx, long dy, long cButtons, long dwExtraInfo); 
'@

    $SendMouseClick = Add-Type -memberDefinition $signature -name "Win32MouseEventNew" -namespace Win32Functions -passThru

    $SendMouseClick::mouse_event(0x00000002, 0, 0, 0, 0);
    $SendMouseClick::mouse_event(0x00000004, 0, 0, 0, 0);

    write-host "Left Mouse Clicked"
}
#endregion




function autoClick
{
    param([bool]$auto,
          [int]$TimeInterval,
          [System.Windows.Threading.DispatcherTimer]$Timer
          
    )
    
    #$Timer = new-object System.Windows.Threading.DispatcherTimer

    $Timer.Interval = new-timespan -Seconds $TimeInterval 

    if($auto)
    {
        write-host "Starting Clicker..."

        #Process the first Click "manually"
        #GoToLocation
        Click-LeftMouseButton

        $Timer.Add_Tick({

            #GoToLocation


            Click-LeftMouseButton 

            
            
        
        })
        $Timer.Start()
        
        
    }
    else {
        write-host "Stopping Clicker..."
        $Timer.Stop()
       
        
    }

}

function SwitchGUI
{
    param([bool]$isSingleMode,
          [System.Windows.Forms.Panel]$mainPanel,
          [System.Windows.Forms.Button]$sequenceButton)

    if($isSingleMode)
    {
        write-host "Single Mode GUI"
        $mainPanel.Controls.Remove($sequenceButton)
        $singleMode.BackColor = "gray"
        $multiMode.Backcolor = "white"
    }
    else 
    {    
        write-host "Multi mode GUI"
        $mainPanel.Controls.Add($sequenceButton)
        $singleMode.BackColor = "white"
        $multiMode.Backcolor = "gray"
    }
}







#Create the Timer variable 
$runTimer = new-object System.Windows.Threading.DispatcherTimer

#Button Click for Single or Multi
$singleMode.Add_Click({SwitchGUI -isSingleMode $true -mainPanel $panel -sequenceButton $addNewToSequence})
$multiMode.Add_Click({SwitchGUI -isSingleMode $false -mainPanel $panel -sequenceButton $addNewToSequence})
$triggerbutton.Add_Click({autoClick -auto $true -TimeInterval $IntervalTextbox.text -Timer $runTimer})
$stopbutton.Add_Click({autoClick -auto $false -Timer $runTimer})

#$triggerbutton.Add_Click({autoClick -auto $true -TimeInterval $IntervalTextbox.text })
#$stopbutton.Add_Click({autoClick -auto $false })
    








#Display Form
$mainform.ShowDialog()

