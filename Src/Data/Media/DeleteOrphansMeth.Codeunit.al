codeunit 58101 "DeleteOrphans Meth WLD"
{
    internal procedure DeleteSelected()
    var
        IsHandled: Boolean;
    begin
        OnBeforeDeleteSelected(IsHandled);

        DoDeleteSelected(IsHandled);

        OnAfterDeleteSelected();
    end;

    local procedure DoDeleteSelected(IsHandled: Boolean);
    var
        TenantMediaOrphanSYSD: Record "Tenant Media Orphan  WLD";
        TenantMediaOrphanSYSD2: Record "Tenant Media Orphan  WLD";
        TenantMedia: Record "Tenant Media";
        TenantMediaThumbnails: Record "Tenant Media Thumbnails";
        i: integer;
    begin
        if IsHandled then
            exit;

        i := 0;

        TenantMediaOrphanSYSD.SetRange(Select, true);
        if not TenantMediaOrphanSYSD.FindSet() then exit;
        repeat
            i += 1;
            if (i mod 1000 = 0) then begin
                commit();
                sleep(100);
            end;

            TenantMediaOrphanSYSD2 := TenantMediaOrphanSYSD;

            TenantMedia.get(TenantMediaOrphanSYSD.MediaID);
            TenantMediaThumbnails.Setrange("Media ID", TenantMedia.ID);

            TenantMedia.Delete(true);
            TenantMediaThumbnails.DeleteAll(true);
            TenantMediaOrphanSYSD2.Delete(true);

        until TenantMediaOrphanSYSD.Next() < 1;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeDeleteSelected(var IsHandled: Boolean);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterDeleteSelected();
    begin
    end;
}