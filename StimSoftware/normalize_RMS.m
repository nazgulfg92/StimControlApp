function [ norm_x, adjust_x, adjust_factor ] = normalize_RMS( x, x_ref, x_ref_dBSPL, x_target_dBSPL )

    rms_now = rms( x );
    rms_ref = rms( x_ref );
    
    % scaling factor for x_ref_dBSPL
    n = numel(x);
    norm_x = x .* ( rms_ref ./ rms_now );
    % so now x is at x_ref_dBSPL
    
    % adjust x to make it with the desired output dBSPL
    db_ref = mag2db( rms_ref );
    dbdiff = x_ref_dBSPL - x_target_dBSPL;
    db_adjusted = db_ref - dbdiff; % target dpSPL with the RMS
    
    new_RMS_target = db2mag( db_adjusted );
    adjust_x = norm_x .* ( new_RMS_target ./ rms_ref );
    
    adjust_factor = rms( adjust_x ) ./ rms(x);
end

