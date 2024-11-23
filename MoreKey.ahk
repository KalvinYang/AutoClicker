make_gui()

make_gui() {
	global MyGui := Gui()
	MyGui.Title := 'MoreKey Autoclicker'
	MyGui.MarginX := 0
	MyGui.MarginY := 0
	MyGui.BackColor := 008080
	MyGui.Opt("-Resize -MaximizeBox")

	MyGui.Add("Text", "x50 y20 w300 h50", "MoreKey Autoclicker:").SetFont("cFFFFFF s15 w5")
	MyGui.Add("Text", "x50 y50 w300 h50", "To end program press together: 1 + 2").SetFont("cFFFFFF s12 w2")
	MyGui.Add("Text", "x50 y70 w300 h50", "To reset press together: 9 + 0").SetFont("cFFFFFF s12 w2")


	MyGui.Add("Text", "x50 y100 w100 h50", "C/Sec:").SetFont("cFFFFFF s15 w5")
	global numbers := Array(50,10,4,2,1)
	global numba := MyGui.AddDropDownList("x50 y130 w100 vNumberChoice", numbers)

	MyGui.Add("Text", "x190 y100 w100 h50", "Off/On:").SetFont("cFFFFFF s15 w5")
	MyGui.Add("Text", "x190 y130 w100 h50", "On: \ - Off: ]").SetFont("cFFFFFF s12 w2")

	MyGui.Add("Button", "x50 y165 w100 Default", "Start").OnEvent("Click", ButtonGo)

	MyGui.Add("Button", "x190 y165 w100 Default", "Test Button").OnEvent("Click", TestGo)

	MyGui.Show("w360 h205")
}

ResetClicks(*) {
	counter.Value := 0
}

TickOnce(*) {
	counter.Value += 1
}

make_test() {
	global TestGui := Gui()
	TestGui.Title := 'Clicker Button'
	TestGui.MarginX := 0
	TestGui.MarginY := 0
	TestGui.BackColor := 008080
	TestGui.Opt("-Resize -MaximizeBox")
	
	global counter := TestGui.Add("Text","Center x0 y10 w200 h30", 0)
	counter.SetFont("cFFFFFF s12 w2")

	TestGui.Add("Button", "x80 y40 w40 h20 Default", "Click").OnEvent("Click", TickOnce)	
	TestGui.Add("Button", "x80 y70 w40 h20 Default", "Close").OnEvent("Click", KillTest)
	TestGui.Show("w200 h110")
}

TestGo(*) {
	try {
		KillTest()
		ResetClicks()
	}
	make_test()
}

KillTest(*) {
	TestGui.Destroy()
}

ButtonGo(*) {
	if (numba.Value > 0) {
		global Selection := numba.Value
		MyGui.Destroy()
	}
	else {
		MsgBox "Invalid choice.", "Choice", "T1"
	}
}

DestroyGui(*) {
	try {
		if !WinActive(MyGui.Hwnd) {
			WinActivate(MyGui.Hwnd)
		}
		MyGui.Destroy()
	}
}

\::
{
	global Selection
	static speed := Array(20,100,250,500,1000)
	loop{
		Click
		Sleep speed[Selection]
		if (GetKeyState("]")) {
    			break
		}
	}
}

9 & 0::
{
	DestroyGui()
	make_gui()
}
1 & 2::
{
	DestroyGui()
	try {
		KillTest()
	}
	MsgBox "MoreKey Autoclicker has ended.",  "MoreKey Autoclicker", "T2"
	ExitApp
}