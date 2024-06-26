
[Setting name="File dialog character limit"]
int Setting_FileDialogCharacterLimit = 150;

void Main()
{
    bool maxLengthSet = false;
    int lastCharLimit = Setting_FileDialogCharacterLimit;

    while (true)
    {
        yield();

        if (GetApp().ActiveMenus.Length > 0)
        {
            if (maxLengthSet
                // Allow another update of the MaxLength if the user changes
                // the settings while the dialog is open
                && lastCharLimit == Setting_FileDialogCharacterLimit)
            {
                continue;
            }

            CGameMenuFrame@ cf = GetApp().ActiveMenus[0].CurrentFrame;
            if (cf !is null
                && cf.IdName == "FrameDialogSaveAs")
            {
                CControlEntry@ entry = cast<CControlEntry>(
                    GetFirstChild(GetFirstChild(GetFirstChild(cf, "FrameContent"), "FrameSave"), "EntryFileName")
                );
                if (entry !is null)
                {
                    entry.MaxLength = Setting_FileDialogCharacterLimit;
                    maxLengthSet = true;
                }
            }
        }
        else
        {
            maxLengthSet = false;
        }

        lastCharLimit = Setting_FileDialogCharacterLimit;
    }
}

CControlBase@ GetFirstChild(CControlBase@ control, const string&in name)
{
    CControlBase@ child = null;
    CControlContainer@ container = cast<CControlContainer>(control);
    if (container !is null)
    {
        for (uint i = 0; i < container.Childs.Length; ++i)
        {
            if (container.Childs[i] !is null && container.Childs[i].IdName == name)
            {
                @child = container.Childs[i];
                break;
            }
        }
    }
    return child;
}
