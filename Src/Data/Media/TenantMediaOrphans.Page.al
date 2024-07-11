page 58100 "Tenant Media Orphans WLD"
{
    ApplicationArea = All;
    Caption = 'Tenant Media Orphans';
    PageType = List;
    SourceTable = "Tenant Media Orphan  WLD";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Select; Rec.Select)
                {
                    ApplicationArea = All;
                    Tooltip = 'Select for delete';
                }
                field(MediaID; Rec.MediaID)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the ID field.';
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Length; Rec.Length)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Height field.';
                }
                field(Height; Rec.Height)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Height field.';
                }
                field(Width; Rec.Width)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Width field.';
                }
                field("Company Name"; Rec."Company Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Company Name field.';
                }
                field("Creating User"; Rec."Creating User")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Creating User field.';
                }
                field("Expiration Date"; Rec."Expiration Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Expiration Date field.';
                }
                field("File Name"; Rec."File Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the File Name field.';
                }
                field("Mime Type"; Rec."Mime Type")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Mime Type field.';
                }
                field("Prohibit Cache"; Rec."Prohibit Cache")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prohibit Cache field.';
                }
                field("Security Token"; Rec."Security Token")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Security Token field.';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.';
                }
                field(SystemId; Rec.SystemId)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemId field.';
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.';
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.';
                }
            }
        }

        area(FactBoxes)
        {
            part(picture; "TenantMedia Picture WLD")
            {
                ApplicationArea = All;
                SubPageLink = ID = field(MediaID);
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(GetOrphans)
            {
                Caption = 'Get Orphans';
                Image = VoidExpiredCheck;
                ApplicationArea = All;
                ToolTip = 'Searches for Orphans, displays them, for you to handle them';

                trigger OnAction()
                var
                    GetTenantMediaOrphansMeth: Codeunit "GetMediaOrphans Meth  WLD";
                begin
                    GetTenantMediaOrphansMeth.GetTenantMediaOrphans();
                end;
            }
            action(SelectAll)
            {
                Image = SelectMore;
                ToolTip = 'Executes the SelectAll action.';
                trigger OnAction()
                begin
                    Rec.ModifyAll(Select, true, false);
                end;
            }
            action(UnSelectAll)
            {
                Image = Undo;
                ToolTip = 'Executes the UnSelectAll action.';
                trigger OnAction()
                begin
                    Rec.ModifyAll(Select, false, false);
                end;
            }
            action(DeleteSelected)
            {
                Image = DeleteRow;
                Caption = 'Delete Selected';
                ToolTip = 'Executes the Delete Selected action.';
                trigger OnAction()
                var
                    DeleteOrphansMethSYSD: Codeunit "DeleteOrphans Meth WLD";
                begin
                    if not Confirm('Are you sure? Make sure you have a backup!', false) then exit;

                    DeleteOrphansMethSYSD.DeleteSelected();
                end;
            }
        }
        area(Promoted)
        {
            actionref(GetOrphansRef; GetOrphans) { }
            Group(SelectRecords)
            {
                ShowAs = SplitButton;
                actionref(SelectAllRef; SelectAll) { Visible = true; }
                actionref(UnSelectAllRef; UnSelectAll) { Visible = true; }
            }
            actionref(DeleteSelectedRef; DeleteSelected) { Visible = true; }
        }
    }
}
