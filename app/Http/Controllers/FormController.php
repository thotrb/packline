<?php


namespace App\Http\Controllers;


use App\Models\ole_assignement_team_po;
use App\Models\ole_planned_events;
use App\Models\ole_pos;
use App\Models\ole_rejection_counters;
use App\Models\ole_speedLoss;
use App\Models\ole_unplanned_event_changing_client;
use App\Models\ole_unplanned_event_changing_format;
use App\Models\ole_unplanned_event_CIP;
use App\Models\ole_unplannedEvent_unplannedDowntime;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class FormController extends Controller
{

    public function unplannedDowntimeDashboard()
    {
        return view('unplannedDowntimeDashboard');
    }

    public function unplannedDowntimeShutdowns()
    {
        return view('unplannedDowntimeShutdowns');
    }

    public function unplannedDowntimeSpeedLosses()
    {
        return view('unplannedDowntimeSpeedLosses');
    }

    public function qualityLossesDashboard()
    {
        return view('qualityLossesDashboard');
    }

    public function index()
    {
        return view('teamInfo');
    }

    public function downtimesReport()
    {
        return view('downtimesReport');
    }


    public function getUnplannedDowntimeEvents($productionLine, $beginningDate, $endingDate)
    {

        $CIP = DB::table('ole_unplanned_event_cips')
            ->where('ole_unplanned_event_cips.productionline', '=', $productionLine)
            ->whereDate('ole_unplanned_event_cips.created_at', '>=', $beginningDate)
            ->whereDate('ole_unplanned_event_cips.created_at', '<=', $endingDate)
            ->get();

        $COV = DB::table('ole_unplanned_event_changing_clients')
            ->where('ole_unplanned_event_changing_clients.productionline', '=', $productionLine)
            ->whereDate('ole_unplanned_event_changing_clients.created_at', '>=', $beginningDate)
            ->whereDate('ole_unplanned_event_changing_clients.created_at', '<=', $endingDate)
            ->get();

        $BNC = DB::table('ole_unplanned_event_changing_formats')
            ->where('ole_unplanned_event_changing_formats.productionline', '=', $productionLine)
            ->whereDate('ole_unplanned_event_changing_formats.created_at', '>=', $beginningDate)
            ->whereDate('ole_unplanned_event_changing_formats.created_at', '<=', $endingDate)
            ->get();

        $machineShutdowns = DB::table('ole_unplanned_event_unplanned_downtimes')
            ->where('ole_unplanned_event_unplanned_downtimes.implicated_machine', '!=', "other")
            ->where('ole_unplanned_event_unplanned_downtimes.productionline', '=', $productionLine)
            ->whereDate('ole_unplanned_event_unplanned_downtimes.created_at', '>=', $beginningDate)
            ->whereDate('ole_unplanned_event_unplanned_downtimes.created_at', '<=', $endingDate)
            ->get();

        $externalShutdowns = DB::table('ole_unplanned_event_unplanned_downtimes')
            ->where('ole_unplanned_event_unplanned_downtimes.implicated_machine', '=', "other")
            ->where('ole_unplanned_event_unplanned_downtimes.productionline', '=', $productionLine)
            ->whereDate('ole_unplanned_event_unplanned_downtimes.created_at', '>=', $beginningDate)
            ->whereDate('ole_unplanned_event_unplanned_downtimes.created_at', '<=', $endingDate)
            ->get();

        $seqCips = DB::table('ole_unplanned_event_cips')
            ->where('ole_unplanned_event_cips.productionline', '=', $productionLine)
            ->whereDate('ole_unplanned_event_cips.created_at', '>=', $beginningDate)
            ->whereDate('ole_unplanned_event_cips.created_at', '<=', $endingDate)
            ->join('ole_pos', 'ole_pos.number', '=', 'ole_unplanned_event_cips.OLE')
            ->join('ole_products', 'ole_products.GMID', '=', 'ole_pos.GMIDCode')
            ->get();

        $seqCovs = DB::table('ole_unplanned_event_changing_clients')
            ->where('ole_unplanned_event_changing_clients.productionline', '=', $productionLine)
            ->whereDate('ole_unplanned_event_changing_clients.created_at', '>=', $beginningDate)
            ->whereDate('ole_unplanned_event_changing_clients.created_at', '<=', $endingDate)
            ->join('ole_pos', 'ole_pos.number', '=', 'ole_unplanned_event_changing_clients.OLE')
            ->join('ole_products', 'ole_products.GMID', '=', 'ole_pos.GMIDCode')
            ->get();

        $tab = array([
            'CIP' => $CIP,
            'COV' => $COV,
            'BNC' => $BNC,
            'machines' => $machineShutdowns,
            'external' => $externalShutdowns,
            'seqCIP' => $seqCips,
            'seqCOV' => $seqCovs
        ]);

        return response()->json($tab);
    }


    public function getAllVolumes($site, $productionLine, $beginningDate, $endingDate)
    {
        $date1 = explode("-", $beginningDate);
        $beginningYear = $date1[0];
        $beginningMonth = $date1[1];
        $beginningDay = $date1[2];

        $date2 = explode("-", $endingDate);
        $endingYear = $date2[0];
        $endingMonth = $date2[1];
        $endingDay = $date2[2];
        $startDate = Carbon::createFromFormat('Y-m-d', $beginningYear . '-' . $beginningMonth . '-' . $beginningDay)->startOfDay();
        $endDate = Carbon::createFromFormat('Y-m-d', $endingYear . '-' . $endingMonth . '-' . $endingDay)->startOfDay();

        $site = DB::table('ole_productionline')
            ->join('worksite', 'worksite.name', '=', 'ole_productionline.worksite_name')
            ->join('ole_pos', 'ole_pos.productionline_name', '=', 'ole_productionline.productionline_name')
            ->join('ole_products', 'ole_pos.GMIDCode', '=', 'ole_products.GMID')
            ->join('ole_rejection_counters', 'ole_rejection_counters.po', '=', 'ole_pos.number')
            ->where(function ($query) use ($startDate, $endDate, $site, $productionLine) {
                $query->where('worksite.name', '=', $site)
                    ->where('ole_productionline.productionline_name', '=', $productionLine)
                    ->whereBetween(DB::raw('DATE(ole_pos.created_at)'), [$startDate, $endDate]);
            })
            ->get();


        if (count($site) > 0) {

            $tab = array(
                "site" => $site,
                "formulations" => null
            );

        } else {

            $tab = array(
                "site" => null,
                "formulations" => null
            );
        }


        return response()->json($site);

    }

    public function getQualityLossesPeriod($site, $productionLine, $beginningDate, $endingDate)
    {
        $site = DB::table('ole_productionline')
            ->join('worksite', 'worksite.name', '=', 'ole_productionline.worksite_name')
            ->join('ole_pos', 'ole_pos.productionline_name', '=', 'ole_productionline.productionline_name')
            ->join('ole_products', 'ole_pos.GMIDCode', '=', 'ole_products.GMID')
            ->join('ole_rejection_counters', 'ole_rejection_counters.po', '=', 'ole_pos.number')
            ->where('worksite.name', '=', $site)
            ->where('ole_productionline.productionline_name', '=', $productionLine)
            ->whereDate('ole_pos.created_at', '>=', $beginningDate)
            ->whereDate('ole_pos.created_at', '<=', $endingDate)
            ->get();

        if (count($site) > 0) {
            $date1 = explode("-", $beginningDate);
            $beginningYear = $date1[0];
            $beginningMonth = $date1[1];
            $beginningDay = $date1[2];

            $date2 = explode("-", $endingDate);
            $endingYear = $date2[0];
            $endingMonth = $date2[1];
            $endingDay = $date2[2];

            $startDate = Carbon::createFromFormat('Y-m-d', $beginningYear . '-' . $beginningMonth . '-' . $beginningDay)->startOfDay();
            $endDate = Carbon::createFromFormat('Y-m-d', $endingYear . '-' . $endingMonth . '-' . $endingDay)->startOfDay();


            $rejectionCounter = DB::table('ole_rejection_counters')
                ->join('ole_pos', 'ole_pos.number', '=', 'ole_rejection_counters.po')
                ->select(DB::raw('SUM(ole_rejection_counters.fillerCounter) as sumFillerCounter'), DB::raw('SUM(ole_rejection_counters.caperCounter) as sumCaperCounter'), DB::raw('SUM(ole_rejection_counters.labelerCounter) as sumLabelerCounter'),
                    DB::raw('SUM(ole_rejection_counters.weightBoxCounter) as sumWeightBoxCounter'), DB::raw('SUM(ole_rejection_counters.fillerRejection) as sumFillerRejection'), DB::raw('SUM(ole_rejection_counters.caperRejection) as sumCaperRejection'),
                    DB::raw('SUM(ole_rejection_counters.labelerRejection) as sumLabelerRejection'), DB::raw('SUM(ole_rejection_counters.weightBoxRejection) as sumWeightBoxRejection'), DB::raw('SUM(ole_rejection_counters.qualityControlCounter) as sumQualityControlCounter'),
                    DB::raw('SUM(ole_rejection_counters.qualityControlRejection) as sumQualityControlRejection'))
                ->where(function ($query) use ($endDate, $startDate) {
                    $query->whereBetween(DB::raw('DATE(ole_rejection_counters.created_at)'), [$startDate, $endDate]);
                })
                ->where('ole_pos.productionline_name', '=', $productionLine)
                ->get();

            $formats = DB::table('ole_rejection_counters')
                ->where(function ($query) use ($endDate, $startDate) {
                    $query->whereBetween(DB::raw('DATE(ole_rejection_counters.created_at)'), [$startDate, $endDate]);
                })
                ->join('ole_pos', 'ole_rejection_counters.po', '=', 'ole_pos.number')
                ->where('ole_pos.productionline_name', '=', $productionLine)
                ->join('ole_products', 'ole_products.GMID', '=', 'ole_pos.GMIDCode')
                ->get();


            $tab = array(
                'rejectionCounter' => $rejectionCounter,
                'formats' => $formats
            );

        } else {

            $tab = array(
                'rejectionCounter' => null,
                'formats' => null
            );
        }

        return $tab;
    }

    public function getPerformanceForASite($po)
    {

        $RRF = DB::table('ole_speed_losses')
            ->where('ole_speed_losses.OLE', '=', $po)
            ->where('ole_speed_losses.reason', '=', 'Reduced Rate At Filler')
            ->select(DB::raw('SUM(duration) as Duration'), DB::raw('count(*) as nbEvents'))
            ->get();

        $RRM = DB::table('ole_speed_losses')
            ->where('ole_speed_losses.OLE', '=', $po)
            ->where('ole_speed_losses.reason', '=', 'Reduce Rate At An Other Machine')
            ->select(DB::raw('SUM(duration) as Duration'), DB::raw('count(*) as nbEvents'))
            ->get();

        $FOS = DB::table('ole_speed_losses')
            ->where('ole_speed_losses.OLE', '=', $po)
            ->where('ole_speed_losses.reason', '=', 'Filler Own Stoppage')
            ->select(DB::raw('SUM(duration) as Duration'), DB::raw('count(*) as nbEvents'))
            ->get();


        $FSM = DB::table('ole_speed_losses')
            ->where('ole_speed_losses.OLE', '=', $po)
            ->where('ole_speed_losses.reason', '=', 'Filler Own Stoppage By An Other Machine')
            ->select(DB::raw('SUM(duration) as Duration'), DB::raw('count(*) as nbEvents'))
            ->get();

        $tab = array(

            'RRF' => $RRF,
            'RRM' => $RRM,
            'FOS' => $FOS,
            'FSM' => $FSM
        );

        return $tab;


    }

    public function getAllEventsPeriod($site, $productionLine, $beginningDate, $endingDate)
    {
        $site = DB::table('ole_productionline')
            ->join('worksite', 'worksite.name', '=', 'ole_productionline.worksite_name')
            ->join('ole_pos', 'ole_pos.productionline_name', '=', 'ole_productionline.productionline_name')
            ->join('ole_products', 'ole_pos.GMIDCode', '=', 'ole_products.GMID')
            ->join('ole_rejection_counters', 'ole_rejection_counters.po', '=', 'ole_pos.number')
            ->where('worksite.name', '=', $site)
            ->where('ole_productionline.productionline_name', '=', $productionLine)
            ->whereDate('ole_pos.created_at', '>=', $beginningDate)
            ->whereDate('ole_pos.created_at', '<=', $endingDate)
            ->get();


        if (count($site) > 0) {

            $date1 = explode("-", $beginningDate);
            $beginningYear = $date1[0];
            $beginningMonth = $date1[1];
            $beginningDay = $date1[2];

            $date2 = explode("-", $endingDate);
            $endingYear = $date2[0];
            $endingMonth = $date2[1];
            $endingDay = $date2[2];

            $startDate = Carbon::createFromFormat('Y-m-d', $beginningYear . '-' . $beginningMonth . '-' . $beginningDay)->startOfDay();
            $endDate = Carbon::createFromFormat('Y-m-d', $endingYear . '-' . $endingMonth . '-' . $endingDay)->startOfDay();


            $speedLossesEvents = DB::table('ole_speed_losses')
                ->select('ole_speed_losses.duration', 'ole_speed_losses.reason', 'ole_speed_losses.comment', 'ole_pos.id', 'ole_pos.qtyProduced', 'ole_pos.workingDuration', 'ole_products.size', 'ole_products.idealRate')
                ->where('ole_speed_losses.productionline', '=', $productionLine)
                ->whereDate('ole_speed_losses.created_at', '>=', $beginningDate)
                ->whereDate('ole_speed_losses.created_at', '<=', $endingDate)
                ->join('ole_pos', 'ole_pos.number', '=', 'ole_speed_losses.OLE')
                ->join('ole_products', 'ole_products.GMID', '=', 'ole_pos.GMIDCode')
                ->get();


            $BM = DB::table('ole_planned_events')
                ->where(function ($query) use ($endDate, $startDate, $site) {
                    $query->where('ole_planned_events.productionline', '=', $site[0]->productionline_name)
                        ->where('ole_planned_events.reason', '=', 'Pause')
                        ->whereBetween(DB::raw('DATE(ole_planned_events.created_at)'), [$startDate, $endDate]);

                })
                ->orWhere(function ($query) use ($endDate, $startDate, $site) {
                    $query->where('ole_planned_events.productionline', '=', $site[0]->productionline_name)
                        ->where('ole_planned_events.reason', '=', 'Reunion')
                        ->whereBetween(DB::raw('DATE(ole_planned_events.created_at)'), [$startDate, $endDate]);

                })
                ->orWhere(function ($query) use ($endDate, $startDate, $site) {
                    $query->where('ole_planned_events.productionline', '=', $site[0]->productionline_name)
                        ->where('ole_planned_events.reason', '=', 'Pas de production prevue')
                        ->whereBetween(DB::raw('DATE(ole_planned_events.created_at)'), [$startDate, $endDate]);

                })
                ->select(DB::raw('SUM(duration) as Duration'), DB::raw('count(*) as nbEvents'))
                ->get();


            $CP = DB::table('ole_planned_events')
                ->where(function ($query) use ($endDate, $startDate, $site) {
                    $query->where('ole_planned_events.productionline', '=', $site[0]->productionline_name)
                        ->where('ole_planned_events.reason', '=', 'Implementation de projet')
                        ->whereBetween(DB::raw('DATE(ole_planned_events.created_at)'), [$startDate, $endDate]);

                })
                ->select(DB::raw('SUM(duration) as Duration'), DB::raw('count(*) as nbEvents'))
                ->get();


            $PM = DB::table('ole_planned_events')
                ->where(function ($query) use ($endDate, $startDate, $site) {
                    $query->where('ole_planned_events.productionline', '=', $site[0]->productionline_name)
                        ->where('ole_planned_events.reason', '=', 'Maintenance')
                        ->whereBetween(DB::raw('DATE(ole_planned_events.created_at)'), [$startDate, $endDate]);

                })
                ->select(DB::raw('SUM(duration) as Duration'), DB::raw('count(*) as nbEvents'))
                ->get();


            $PP = DB::table('ole_planned_events')
                ->where(function ($query) use ($endDate, $startDate, $site) {
                    $query->where('ole_planned_events.productionline', '=', $site[0]->productionline_name)
                        ->where('ole_planned_events.reason', '=', 'Pas de production prevue')
                        ->whereBetween(DB::raw('DATE(ole_planned_events.created_at)'), [$startDate, $endDate]);

                })
                ->select(DB::raw('SUM(duration) as Duration'), DB::raw('count(*) as nbEvents'))
                ->get();


            $CIP = DB::table('ole_unplanned_event_cips')
                ->where(function ($query) use ($endDate, $startDate, $site) {
                    $query->where('ole_unplanned_event_cips.productionline', '=', $site[0]->productionline_name)
                        ->whereBetween(DB::raw('DATE(ole_unplanned_event_cips.created_at)'), [$startDate, $endDate]);

                })
                ->select(DB::raw('SUM(total_duration) as Duration'), DB::raw('count(*) as nbEvents'))
                ->get();


            $COV = DB::table('ole_unplanned_event_changing_clients')
                ->where(function ($query) use ($endDate, $startDate, $site) {
                    $query->where('ole_unplanned_event_changing_clients.productionline', '=', $site[0]->productionline_name)
                        ->whereBetween(DB::raw('DATE(ole_unplanned_event_changing_clients.created_at)'), [$startDate, $endDate]);

                })
                ->select(DB::raw('SUM(total_duration) as Duration'), DB::raw('count(*) as nbEvents'))
                ->get();


            $BNC = DB::table('ole_unplanned_event_changing_formats')
                ->where(function ($query) use ($endDate, $startDate, $site) {
                    $query->where('ole_unplanned_event_changing_formats.productionline', '=', $site[0]->productionline_name)
                        ->whereBetween(DB::raw('DATE(ole_unplanned_event_changing_formats.created_at)'), [$startDate, $endDate]);

                })
                ->select(DB::raw('SUM(total_duration) as Duration'), DB::raw('count(*) as nbEvents'))
                ->get();


            $UEE = DB::table('ole_unplanned_event_unplanned_downtimes')
                ->where(function ($query) use ($endDate, $startDate, $site) {
                    $query->where('ole_unplanned_event_unplanned_downtimes.productionline', '=', $site[0]->productionline_name)
                        ->whereBetween(DB::raw('DATE(ole_unplanned_event_unplanned_downtimes.created_at)'), [$startDate, $endDate])
                        ->where('ole_unplanned_event_unplanned_downtimes.component', '=', 'other');
                })
                ->select(DB::raw('SUM(total_duration) as Duration'), DB::raw('count(*) as nbEvents'))
                ->get();


            $USM = DB::table('ole_unplanned_event_unplanned_downtimes')
                ->where(function ($query) use ($endDate, $startDate, $site) {
                    $query->where('ole_unplanned_event_unplanned_downtimes.productionline', '=', $site[0]->productionline_name)
                        ->where('ole_unplanned_event_unplanned_downtimes.component', '!=', 'downstreamSaturation')
                        ->whereBetween(DB::raw('DATE(ole_unplanned_event_unplanned_downtimes.created_at)'), [$startDate, $endDate]);

                })
                ->orWhere(function ($query) use ($endDate, $startDate, $site) {
                    $query->where('ole_unplanned_event_unplanned_downtimes.productionline', '=', $site[0]->productionline_name)
                        ->where('ole_unplanned_event_unplanned_downtimes.component', '!=', 'missingBottle')
                        ->whereBetween(DB::raw('DATE(ole_unplanned_event_unplanned_downtimes.created_at)'), [$startDate, $endDate]);

                })
                ->orWhere(function ($query) use ($endDate, $startDate, $site) {
                    $query->where('ole_unplanned_event_unplanned_downtimes.productionline', '=', $site[0]->productionline_name)
                        ->where('ole_unplanned_event_unplanned_downtimes.component', '!=', 'other')
                        ->whereBetween(DB::raw('DATE(ole_unplanned_event_unplanned_downtimes.created_at)'), [$startDate, $endDate]);

                })
                ->select(DB::raw('SUM(total_duration) as Duration'), DB::raw('count(*) as nbEvents'))
                ->get();


            $FUS = DB::table('ole_unplanned_event_unplanned_downtimes')
                ->where(function ($query) use ($endDate, $startDate, $site) {
                    $query->where('ole_unplanned_event_unplanned_downtimes.productionline', '=', $site[0]->productionline_name)
                        ->where('ole_unplanned_event_unplanned_downtimes.component', '=', 'downstreamSaturation')
                        ->whereBetween(DB::raw('DATE(ole_unplanned_event_unplanned_downtimes.created_at)'), [$startDate, $endDate]);

                })
                ->orWhere(function ($query) use ($endDate, $startDate, $site) {
                    $query->where('ole_unplanned_event_unplanned_downtimes.productionline', '=', $site[0]->productionline_name)
                        ->where('ole_unplanned_event_unplanned_downtimes.component', '=', 'missingBottle')
                        ->whereBetween(DB::raw('DATE(ole_unplanned_event_unplanned_downtimes.created_at)'), [$startDate, $endDate]);

                })
                ->select(DB::raw('SUM(total_duration) as Duration'), DB::raw('count(*) as nbEvents'))
                ->get();


            $RRF = DB::table('ole_speed_losses')
                ->where(function ($query) use ($endDate, $startDate, $site) {
                    $query->where('ole_speed_losses.productionline', '=', $site[0]->productionline_name)
                        ->where('ole_speed_losses.reason', '=', 'Reduced Rate At Filler')
                        ->whereBetween(DB::raw('DATE(ole_speed_losses.created_at)'), [$startDate, $endDate]);

                })
                ->select(DB::raw('SUM(duration) as Duration'), DB::raw('count(*) as nbEvents'))
                ->get();

            $RRFMonth = DB::table('ole_speed_losses')
                ->where(function ($query) use ($endDate, $startDate, $site) {
                    $query->where('ole_speed_losses.productionline', '=', $site[0]->productionline_name)
                        ->where('ole_speed_losses.reason', '=', 'Reduced Rate At Filler')
                        ->whereBetween(DB::raw('DATE(ole_speed_losses.created_at)'), [$startDate, $endDate]);

                })
                ->get();

            $RRMMonth = DB::table('ole_speed_losses')
                ->where(function ($query) use ($endDate, $startDate, $site) {
                    $query->where('ole_speed_losses.productionline', '=', $site[0]->productionline_name)
                        ->where('ole_speed_losses.reason', '=', 'Reduce Rate At An Other Machine')
                        ->whereBetween(DB::raw('DATE(ole_speed_losses.created_at)'), [$startDate, $endDate]);

                })
                ->get();

            $FOSMonth = DB::table('ole_speed_losses')
                ->where(function ($query) use ($endDate, $startDate, $site) {
                    $query->where('ole_speed_losses.productionline', '=', $site[0]->productionline_name)
                        ->where('ole_speed_losses.reason', '=', 'Filler Own Stoppage')
                        ->whereBetween(DB::raw('DATE(ole_speed_losses.created_at)'), [$startDate, $endDate]);

                })
                ->get();

            $FSMMonth = DB::table('ole_speed_losses')
                ->where(function ($query) use ($endDate, $startDate, $site) {
                    $query->where('ole_speed_losses.productionline', '=', $site[0]->productionline_name)
                        ->where('ole_speed_losses.reason', '=', 'Filler Own Stoppage By An Other Machine')
                        ->whereBetween(DB::raw('DATE(ole_speed_losses.created_at)'), [$startDate, $endDate]);

                })
                ->get();


            $RRM = DB::table('ole_speed_losses')
                ->where(function ($query) use ($endDate, $startDate, $site) {
                    $query->where('ole_speed_losses.productionline', '=', $site[0]->productionline_name)
                        ->where('ole_speed_losses.reason', '=', 'Reduce Rate At An Other Machine')
                        ->whereBetween(DB::raw('DATE(ole_speed_losses.created_at)'), [$startDate, $endDate]);

                })
                ->select(DB::raw('SUM(duration) as Duration'), DB::raw('count(*) as nbEvents'))
                ->get();


            $FOS = DB::table('ole_speed_losses')
                ->where(function ($query) use ($endDate, $startDate, $site) {
                    $query->where('ole_speed_losses.productionline', '=', $site[0]->productionline_name)
                        ->where('ole_speed_losses.reason', '=', 'Filler Own Stoppage')
                        ->whereBetween(DB::raw('DATE(ole_speed_losses.created_at)'), [$startDate, $endDate]);

                })
                ->select(DB::raw('SUM(duration) as Duration'), DB::raw('count(*) as nbEvents'))
                ->get();


            $FSM = DB::table('ole_speed_losses')
                ->where(function ($query) use ($endDate, $startDate, $site) {
                    $query->where('ole_speed_losses.productionline', '=', $site[0]->productionline_name)
                        ->where('ole_speed_losses.reason', '=', 'Filler Own Stoppage By An Other Machine')
                        ->whereBetween(DB::raw('DATE(ole_speed_losses.created_at)'), [$startDate, $endDate]);

                })
                ->select(DB::raw('SUM(duration) as Duration'), DB::raw('count(*) as nbEvents'))
                ->get();


            $plannedEvents = DB::table('ole_planned_events')
                ->where(function ($query) use ($endDate, $startDate, $site) {
                    $query->where('ole_planned_events.productionline', '=', $site[0]->productionline_name)
                        ->whereBetween(DB::raw('DATE(ole_planned_events.created_at)'), [$startDate, $endDate]);
                })
                ->get();

            $changingClients = DB::table('ole_unplanned_event_changing_clients')
                ->where(function ($query) use ($endDate, $startDate, $site) {
                    $query->where('ole_unplanned_event_changing_clients.productionline', '=', $site[0]->productionline_name)
                        ->whereBetween(DB::raw('DATE(ole_unplanned_event_changing_clients.created_at)'), [$startDate, $endDate]);
                })
                ->get();

            $CIPBis = DB::table('ole_unplanned_event_cips')
                ->where(function ($query) use ($endDate, $startDate, $site) {
                    $query->where('ole_unplanned_event_cips.productionline', '=', $site[0]->productionline_name)
                        ->whereBetween(DB::raw('DATE(ole_unplanned_event_cips.created_at)'), [$startDate, $endDate]);
                })
                ->get();


            $unplanned = DB::table('ole_unplanned_event_unplanned_downtimes')
                ->where(function ($query) use ($endDate, $startDate, $site) {
                    $query->where('ole_unplanned_event_unplanned_downtimes.productionline', '=', $site[0]->productionline_name)
                        ->whereBetween(DB::raw('DATE(ole_unplanned_event_unplanned_downtimes.created_at)'), [$startDate, $endDate]);
                })
                ->get();

            $changingFormats = DB::table('ole_unplanned_event_changing_formats')
                ->where(function ($query) use ($endDate, $startDate, $site) {
                    $query->where('ole_unplanned_event_changing_formats.productionline', '=', $site[0]->productionline_name)
                        ->whereBetween(DB::raw('DATE(ole_unplanned_event_changing_formats.created_at)'), [$startDate, $endDate]);
                })
                ->get()
                ->union($changingClients)
                ->union($CIPBis)
                ->union($unplanned);
            //->union($plannedEvents);

            $tab = array(

                'BM' => $BM,
                'CP' => $CP,
                'PM' => $PM,
                'PP' => $PP,
                'CIP' => $CIP,
                'COV' => $COV,
                'BNC' => $BNC,
                'UEE' => $UEE,
                'USM' => $USM,
                'FUS' => $FUS,
                'RRF' => $RRF,
                'RRM' => $RRM,
                'FOS' => $FOS,
                'FSM' => $FSM,
                'SITE' => $site,
                'EVENTS' => $changingFormats,
                'SLEVENTS' => $speedLossesEvents,
                'PLANNEDEVENTS' => $plannedEvents,
                'RRFMonth' => $RRFMonth,
                'RRMMonth' => $RRMMonth,
                'FOSMonth' => $FOSMonth,
                'FSMMonth' => $FSMMonth,
            );


        } else {
            $tab = array(

                'BM' => 0,
                'CP' => 0,
                'PM' => 0,
                'PP' => 0,
                'CIP' => 0,
                'COV' => 0,
                'BNC' => 0,
                'UEE' => 0,
                'USM' => 0,
                'FUS' => 0,
                'RRF' => 0,
                'RRM' => 0,
                'FOS' => 0,
                'FSM' => 0,
                'SITE' => $site,
                'EVENTS' => null,


            );


        }
        return response()->json($tab);


        /**
         *
         *  var sommeQtyProduced2 = 0;
         * this.packsizes = [];
         *
         * var qtyPerPacksize = [];
         *
         * for (let i = 0; i < this.volumes.length; i++) {
         * sommeQtyProduced2 += this.volumes[i].qtyProduced * this.volumes[i].bottlesPerCase * 1;
         * if (!this.packsizes.includes(this.volumes[i].size)) {
         *
         * this.packsizes.push(this.volumes[i].size);
         *
         * qtyPerPacksize[this.volumes[i].size] = this.volumes[i].qtyProduced * this.volumes[i].bottlesPerCase  * 1;
         * } else {
         * qtyPerPacksize[this.volumes[i].size] += this.volumes[i].qtyProduced * this.volumes[i].bottlesPerCase  * 1;
         * }
         * }
         *
         * var finalValue2 = [];
         * for (let j = 0; j < this.formulations.length; j++) {
         * tableauFormulation = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
         * var tableauPacksizeValue = [];
         * for (let k = 0; k < tableauFormulation.length; k++) {
         * tableauPacksizeValue[tableauFormulation[k]] = 0;
         * }
         *
         *
         * for (let i = 0; i < this.volumes.length; i++) {
         * if (this.volumes[i].size === this.packsizes[j]) {
         * month = this.volumes[i].created_at.split('-')[1];
         *
         * correspondingMonth = tableauFormulation[month - 1];
         * tableauPacksizeValue[correspondingMonth] += this.volumes[i].qtyProduced * this.volumes[i].bottlesPerCase * 1;
         * }
         * }
         *
         * finalValue2.push(tableauPacksizeValue);
         * }
         *
         * l = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
         * tab = [];
         * for (let k = 0; k < l.length; k++) {
         * tab[l[k]] = 0;
         * }
         * for(let t=0; t<finalValue2.length; t++)
         * {
         * for (let k = 0; k < l.length; k++) {
         * let month = l[k];
         * tab[month] += finalValue2[t][month];
         * this.total2 += finalValue2[t][month];
         * }
         *
         * }
         * this.sumPerMonth2.push(tab);
         * this.packsizePerMonth = finalValue2;
         */


    }


    public function getMachines($productionlineID)
    {
        $machines = DB::table('ole_machines')
            ->join('ole_productionline', 'ole_productionline.productionline_name', '=', 'ole_machines.productionline_name')
            ->where('ole_productionline.id', '=', $productionlineID)
            ->orderBy('ole_machines.ordre', 'ASC')
            ->get();

        $formats = DB::table('ole_formats')
            ->join('ole_productionline', 'ole_productionline.productionline_name', '=', 'ole_formats.productionlineName')
            ->where('ole_productionline.id', '=', $productionlineID)
            ->get();

        //$products = DB::table('ole_products')
        //  ->where('ole_products.productionlineID', '=', $productionlineID)
        //->get();


        $tab = array(

            0 => $machines,
            1 => $formats,
            //2 => $products,
        );


        return response()->json($tab);


    }


    public function indexAdmin()
    {
        return view('packagingLineID');
    }

    public function summary()
    {
        return view('summary');

    }

    public function isAssignationPossible($username, $po, $productionline)
    {


        $assignation = DB::table('ole_assignement_team_pos')
            ->where('ole_assignement_team_pos.username', '=', $username)
            ->where('ole_assignement_team_pos.po', '=', $po)
            ->where('ole_assignement_team_pos.productionline', '=', $productionline)
            ->count();


        return response()->json($assignation);

    }

    public function isPOPossible($po)
    {
        $pon = DB::table('ole_pos')
            ->where('ole_pos.number', '=', $po)
            ->count();

        return response()->json($pon);

    }


    public function monthlyLoadFactor()
    {
        return view('monthlyLoadFactor');
    }

    public function log($username, $password)
    {

        $userInfo = DB::table('user')
            ->where('user.login', '=', $username)
            ->where('user.password', '=', $password)
            ->get();
        return response()->json($userInfo);


    }

    public function saveUnplannedEvent(Request $request)
    {

        $progression = ole_unplannedEvent_unplannedDowntime::create($request->all());
        return response()->json($progression);


    }

    public function getSites()
    {
        $sites = DB::table('worksite')
            ->get();

        $productionLines = DB::table('ole_productionline')
            ->join('worksite', 'worksite.name', '=', 'ole_productionline.worksite_name')
            ->select('ole_productionline.id', 'ole_productionline.productionline_name', 'worksite.id', 'worksite.name')
            ->get();

        $tab = array(
            0 => $sites,
            1 => $productionLines,
        );


        return response()->json($tab);
    }


    public function get($username)
    {

        $userInfo = DB::table('user')
            ->join('worksite', 'user.worksite_name', '=', 'worksite.name')
            ->where('user.login', '=', $username)
            ->get();


        $crewLeaders = DB::table('user')
            ->join('worksite', 'user.worksite_name', '=', 'worksite.name')
            ->where('user.status', '=', 1)
            ->get();


        $shifts = DB::table('user')
            ->join('worksite', 'user.worksite_name', '=', 'worksite.name')
            ->join('teamInfo', 'worksite.name', '=', 'teamInfo.worksite_name')
            ->where('user.login', '=', $username)
            ->get();


        $productionLine = DB::table('user')
            ->join('worksite', 'user.worksite_name', '=', 'worksite.name')
            ->join('ole_productionline', 'ole_productionline.worksite_name', '=', 'worksite.name')
            ->where('user.login', '=', $username)
            ->select('ole_productionline.productionline_name', 'worksite.id')
            ->get();


        $tab = array(
            0 => $userInfo,
            1 => $crewLeaders,
            2 => $shifts,
            3 => $productionLine,
        );


        return response()->json($tab);


    }

    public function choicePlannedUnplanned($productionName)
    {

        return view('incidentDeclaration');
    }

    public function getDowntimeReasons($productionName, $downTimeType)
    {

        $downTimeReasons = DB::table('ole_downtimeReason')
            ->where('ole_downtimeReason.downtimeType', '=', $downTimeType)
            ->get();


        return response()->json($downTimeReasons);

    }


    public function downtimeReason_1($downtimeType)
    {
        return view('unplannedDowntime_Screen1');

    }

    public function plannedDowntime_Event()
    {
        return view('plannedDowntime_declaration');

    }

    public function productionDashboard()
    {
        return view('productionDashboard');

    }

    public function unplannedDowntime_2()
    {
        return view('unplannedDowntime_unplannedDowntime_Screen2');

    }

    public function get_unplannedDowntime_2()
    {
        $machines = DB::table('ole_machines')
            ->where('ole_machines.name', '!=', 'filler')
            ->get();
        return response()->json($machines);

    }

    public function get_unplannedDowntime_Machine_Issue($machineName)
    {
        $issues = DB::table('machine_component')
            ->join('ole_machines', 'ole_machines.name', '=', 'machine_component.machineName')
            ->where('ole_machines.name', '=', $machineName)
            ->select('machine_component.name as component', 'ole_machines.name', 'other_machine')
            ->get();

        return response()->json($issues);
    }

    public function get_speedLosses($PO, $productionLine)
    {
        $speedLosses = DB::table('ole_speed_losses')
            ->where('ole_speed_losses.productionline', '=', $productionLine)
            ->where('ole_speed_losses.OLE', '=', $PO)
            ->get();

        return response()->json($speedLosses);


    }

    public function getPOsFromShift($shift, $site)
    {

        $pos = DB::table('worksite')
            ->where('worksite.name', '=', $site)
            ->join('ole_assignement_team_po', 'ole_assignement_team_po.worksite', '=', 'worksite.id')
            ->join('ole_pos', 'ole_pos.number', '=', 'ole_assignement_team_po.po')
            ->where('ole_assignement_team_po.shift', '=', $shift)
            ->get();


        return response()->json($pos);

    }

    public function getWorksiteID($worksite)
    {
        $worksiteID = $pos = DB::table('worksite')
            ->where('worksite.name', '=', $worksite)
            ->select('worksite.id')
            ->get();

        return response()->json($worksiteID);
    }

    public function getProductionlineID($productionline)
    {

        $productionlineID = DB::table('ole_productionline')
            ->where('ole_productionline.productionline_name', '=', $productionline)
            ->select('ole_productionline.id')
            ->get();

        return response()->json($productionlineID);

    }

    public function createAssignement(Request $request)
    {

        $PO = ole_assignement_team_po::create($request->all());
        printf(response()->json($PO));
        return response()->json($PO);


    }

    public function getNetOP($GMID)
    {
        $netOp = DB::table('ole_products')
            ->where('ole_products.GMID', '=', $GMID)
            ->first();
        return response()->json($netOp);

    }


    public function getEvents($PO, $productionLine)
    {

        $plannedEvents = DB::table('ole_planned_events')
            ->where('ole_planned_events.productionline', '=', $productionLine)
            ->where('ole_planned_events.OLE', '=', $PO)
            ->select('duration as total_duration', 'reason as type', 'comment', 'updated_at', 'OLE', 'productionline', 'kind');

        $changingClients = DB::table('ole_unplanned_event_changing_clients')
            ->where('ole_unplanned_event_changing_clients.productionline', '=', $productionLine)
            ->where('ole_unplanned_event_changing_clients.OLE', '=', $PO)
            ->select('total_duration', 'type', 'comment', 'updated_at', 'OLE', 'productionline', 'kind');


        $CIP = DB::table('ole_unplanned_event_cips')
            ->where('ole_unplanned_event_cips.productionline', '=', $productionLine)
            ->where('ole_unplanned_event_cips.OLE', '=', $PO)
            ->select('total_duration', 'type', 'comment', 'updated_at', 'OLE', 'productionline', 'kind');


        $unplanned = DB::table('ole_unplanned_event_unplanned_downtimes')
            ->where('ole_unplanned_event_unplanned_downtimes.productionline', '=', $productionLine)
            ->where('ole_unplanned_event_unplanned_downtimes.OLE', '=', $PO)
            ->select('total_duration', 'type', 'comment', 'updated_at', 'OLE', 'productionline', 'kind');


        $changingFormats = DB::table('ole_unplanned_event_changing_formats')
            ->where('ole_unplanned_event_changing_formats.productionline', '=', $productionLine)
            ->where('ole_unplanned_event_changing_formats.OLE', '=', $PO)
            ->select('total_duration', 'type', 'comment', 'updated_at', 'OLE', 'productionline', 'kind')
            ->union($changingClients)
            ->union($CIP)
            ->union($unplanned)
            ->union($plannedEvents)
            ->orderBy('updated_at', 'ASC')
            ->get();


        return response()->json($changingFormats);

    }

    public function unplannedDowntime_CIP()
    {
        return view('unplannedDowntime_CIP');

    }

    public function overallLineEffectivness()
    {
        return view('overallLineEffectivness');
    }

    public function unplannedDowntime_changingFormat()
    {
        return view('unplannedDowntime_changingFormat');
    }

    public function unplannedDowntime_clientChanging()
    {
        return view('unplannedDowntime_clientChanging');
    }

    public function endPO()
    {
        return view('endPO_Declaration');

    }

    public function createPO(Request $request)
    {


        $PO = ole_pos::create($request->all());
        printf(response()->json($PO));
        return response()->json($PO);

    }


    public function saveUnplannedEvent_Changingformat(Request $request)
    {

        $event = ole_unplanned_event_changing_format::create($request->all());
        printf(response()->json($event));
        return response()->json($event);

    }


    public function saveUnplannedEvent_Clientchanging(Request $request)
    {

        $event = ole_unplanned_event_changing_client::create($request->all());
        printf(response()->json($event));
        return response()->json($event);

    }

    public function saveUnplannedEvent_CIP(Request $request)
    {

        $event = ole_unplanned_event_cip::create($request->all());
        printf(response()->json($event));
        return response()->json($event);
    }

    public function savePlannedEvent(Request $request)
    {

        $event = ole_planned_events::create($request->all());
        printf(response()->json($event));
        return response()->json($event);
    }

    public function storeRejection(Request $request)
    {
        $event = ole_rejection_counters::create($request->all());
        return response()->json($event);
    }

    public function saveSpeedLoss(Request $request)
    {
        $event = ole_speedLoss::create($request->all());
        printf(response()->json($event));
        return response()->json($event);
    }

    public function stopPO($PO, $availability, $performance, $quality, $OLE, $quantityProduced, $totalDuration)
    {
        $update = DB::update(
            'update ole_pos set state = 0, performance = ?, availability = ?, quality = ?, OLE = ?, qtyProduced = ?, workingDuration = ? where number = ?',
            [$performance, $availability, $quality, $OLE, $quantityProduced, $totalDuration, $PO]
        );
        return response()->json($update);


    }

}
