//
//  ConferenceViewController.swift
//  VoxeetSDK Sample
//
//  Created by Corentin Larroque on 28/04/16.
//  Copyright © 2016 Voxeet. All rights reserved.
//

import UIKit
import VoxeetSDK
import AVKit

/*
 *  MARK: - Conference class
 */

class ConferenceViewController: UIViewController {
    @IBOutlet weak var aliasLabel: UILabel!
    @IBOutlet weak var ownCameraView: VTVideoView!
    @IBOutlet weak var ownCameraHandlerButton: UIButton!
    @IBOutlet weak var switchDeviceSpeakerButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var broadcastMessageButton: UIButton!
    @IBOutlet weak var broadcastMessageTextView: UITextView!
    @IBOutlet weak var screenShareView: VTVideoView!
    @IBOutlet weak var startScreenShareButton: UIButton!
    
    @IBOutlet weak var videoPresentationView: UIView!
    @IBOutlet weak var filePresentationImageView: UIImageView!
    
    @IBOutlet weak var hangUpButton: UIButton!
    
    // Current conference ID.
    var alias: String?
    
    // Player for video presentation.
    var player: AVPlayer?
    
    /*
     *  MARK: Load / Unload
     */
    
    override func viewDidLoad() {
        initConference()
        
        // Check if video is enable by default.
        ownCameraHandlerButton.isSelected = VoxeetSDK.shared.conference.defaultVideo
        
        // Screen share feature is only available above (or equal to) iOS 11.
        if #available(iOS 11.0, *) {} else {
            startScreenShareButton.isHidden = true
        }
        
        // Select / Deselect the switchDeviceSpeakerButton when an headset is plugged/unplugged.
        NotificationCenter.default.addObserver(self, selector: #selector(audioSessionRouteChange), name: AVAudioSession.routeChangeNotification, object: nil)
        // Conference destroy observer.
        NotificationCenter.default.addObserver(self, selector: #selector(conferenceDestroyed), name: .VTConferenceDestroyed, object: nil)
        
        // Force the device screen to never going to sleep mode.
        UIApplication.shared.isIdleTimerDisabled = true
        
        // Hide empty cells.
        tableView.tableFooterView = UIView()
    }
    
    func initConference() {
        // Conference delegates.
        VoxeetSDK.shared.conference.delegate = self
        /* VoxeetSDK.shared.conference.cryptoDelegate = self */
        // Command delegate.
        VoxeetSDK.shared.command.delegate = self
        // File presentation delegate.
        VoxeetSDK.shared.filePresentation.delegate = self
        // Video presentation delegate.
        VoxeetSDK.shared.videoPresentation.delegate = self
        
        // Joining / Launching demo.
        if let alias = alias {
            aliasLabel.text = alias
            
            // Creating a conference.
            let options = VTConferenceOptions()
            options.alias = alias
            VoxeetSDK.shared.conference.create(options: options, success: { conference in
                // Joining conference.
                VoxeetSDK.shared.conference.join(conference: conference, options: nil, success: nil, fail: { error in
                    // Debug.
                    print("[Sample] \(String(describing: ConferenceViewController.self)).\(#function).\(#line) - Error: \(error)")
                    self.dismiss(animated: true)
                })
            }, fail: { error in
                // Debug.
                print("[Sample] \(String(describing: ConferenceViewController.self)).\(#function).\(#line) - Error: \(error)")
                self.dismiss(animated: true)
            })
        } else {
            aliasLabel.text = "Demo"
            
            // Creating a demo conference.
            VoxeetSDK.shared.conference.demo { error in
                if let error = error {
                    // Debug.
                    print("[Sample] \(String(describing: ConferenceViewController.self)).\(#function).\(#line) - Error: \(error)")
                    self.dismiss(animated: true)
                }
            }
            
            // Disable useless buttons in demo.
            broadcastMessageButton.isEnabled = false
            broadcastMessageButton.isSelected = false
            startScreenShareButton.isEnabled = false
            startScreenShareButton.isSelected = false
        }
    }
    
    deinit {
        player?.pause()
        player = nil
        
        // Remove observers.
        NotificationCenter.default.removeObserver(self)
        // Reset: Force the device screen to never going to sleep mode.
        UIApplication.shared.isIdleTimerDisabled = false
        
        // Debug.
        print("[Sample] \(String(describing: ConferenceViewController.self)).\(#function).\(#line)")
    }
    
    func activeParticipants() -> [VTParticipant] {
        let participants = VoxeetSDK.shared.conference.current?.participants
            .filter({ $0.id != VoxeetSDK.shared.session.participant?.id })
            .filter({ $0.status == .connected })
        return participants ?? [VTParticipant]()
    }
    
    /*
     *  MARK: Actions
     */
    
    @IBAction func sendBroadcastMessage(_ sender: AnyObject) {
        // Alert view.
        let alertController = UIAlertController(title: "Send Message", message: "Please input the message:", preferredStyle: .alert)
        
        // Alert actions.
        let confirmAction = UIAlertAction(title: "Send", style: .default) { _ in
            if let textField = alertController.textFields?[0],
                let message = textField.text {
                // Sending a broadcast message.
                VoxeetSDK.shared.command.send(message: message, completion: { error in
                    if let error = error {
                        // Debug.
                        print("[Sample] \(String(describing: ConferenceViewController.self)).\(#function).\(#line) - Error: \(error)")
                    }
                })
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        // Alert textField.
        alertController.addTextField { textField in
            textField.placeholder = "Message"
            textField.clearButtonMode = .whileEditing
        }
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func startScreenShare(_ button: UIButton) {
        if #available(iOS 11.0, *) {
            if button.isSelected {
                guard VoxeetSDK.shared.mediaDevice.screenShareMediaStream() == nil else {
                    // Debug.
                    print("[Sample] \(String(describing: ConferenceViewController.self)).\(#function).\(#line) - Error: Only one screen share allowed.")
                    return
                }
                
                button.isEnabled = false
                VoxeetSDK.shared.conference.startScreenShare(completion: { error in
                    DispatchQueue.main.async {
                        button.isEnabled = true
                        
                        if let error = error {
                            // Debug.
                            print("[Sample] \(String(describing: ConferenceViewController.self)).\(#function).\(#line) - Error: \(error)")
                        } else {
                            button.isSelected = false
                            button.setTitle("Stop screen share", for: .normal)
                        }
                    }
                })
            } else {
                button.isEnabled = false
                VoxeetSDK.shared.conference.stopScreenShare(completion: { error in
                    DispatchQueue.main.async {
                        button.isEnabled = true
                        
                        if let error = error {
                            // Debug.
                            print("[Sample] \(String(describing: ConferenceViewController.self)).\(#function).\(#line) - Error: \(error)")
                        } else {
                            button.isSelected = true
                            button.setTitle("Start screen share", for: .normal)
                        }
                    }
                })
            }
        }
    }
    
    @IBAction func switchDeviceSpeaker(_ button: UIButton) {
        VoxeetSDK.shared.mediaDevice.switchDeviceSpeaker()
    }
    
    @IBAction func hangUp(_ sender: AnyObject) {
        hangUpButton.isEnabled = false
        
        VoxeetSDK.shared.conference.leave { error in
            self.hangUpButton.isEnabled = true
            
            if let error = error {
                // Debug.
                print("[Sample] \(String(describing: ConferenceViewController.self)).\(#function).\(#line) - Error: \(error)")
            }
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func switchCamera(_ sender: AnyObject) {
        VoxeetSDK.shared.mediaDevice.switchCamera {
            DispatchQueue.main.async {
                self.ownCameraView.mirrorEffect.toggle()
            }
        }
    }
    
    @IBAction func ownVideo(_ button: UIButton) {
        button.isEnabled = false
        if button.isSelected {
            VoxeetSDK.shared.conference.stopVideo() { _ in
                button.isEnabled = true
            }
        } else {
            VoxeetSDK.shared.conference.startVideo() { _ in
                button.isEnabled = true
            }
        }
        button.isSelected.toggle()
    }
    
    /*
     *  MARK: Observers
     */
    
    @objc func audioSessionRouteChange() {
        DispatchQueue.main.async {
            self.switchDeviceSpeakerButton.isSelected = AVAudioSession.sharedInstance().currentRoute.outputs.first?.portType == AVAudioSession.Port.builtInSpeaker
        }
    }
    
    @objc func conferenceDestroyed(_ notification: Notification) {
        if let conference = notification.userInfo?["conference"] as? VTConference {
            if conference.id == VoxeetSDK.shared.conference.current?.id {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}

/*
 *  MARK: - Conference tableView dataSource & delegate
 */

extension ConferenceViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activeParticipants().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! ConferenceTableViewCell
        
        // Getting the current participant.
        let participants = activeParticipants()
        guard participants.count != 0 && indexPath.row <= participants.count else { return cell }
        let participant = participants[indexPath.row]
        
        // Setting up the cell.
        cell.setUp(participant: participant)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Getting the current participant.
        let participants = activeParticipants()
        let participant = participants[(indexPath as NSIndexPath).row]
        
        // Mute a user.
        let mute = !participant.mute
        VoxeetSDK.shared.conference.mute(participant: participant, isMuted: mute)
        
        if let cell = tableView.cellForRow(at: indexPath) {
            if #available(iOS 13.0, *) {
                cell.contentView.backgroundColor = mute ? UIColor.systemRed : UIColor.systemBackground
            } else {
                cell.contentView.backgroundColor = mute ? UIColor.red : UIColor.white
            }
        }
    }
}

/*
 *  MARK: - Conference delegate
 */

extension ConferenceViewController: VTConferenceDelegate {
    func statusUpdated(status: VTConferenceStatus) {}
    
    func participantAdded(participant: VTParticipant) {
        tableView.reloadData()
    }
    
    func participantUpdated(participant: VTParticipant) {
        tableView.reloadData()
    }
    
    func streamAdded(participant: VTParticipant, stream: MediaStream) {
        switch stream.type {
        case .Camera:
            if participant.id == VoxeetSDK.shared.session.participant?.id {
                // Attaching own participant's video stream to the renderer.
                if !stream.videoTracks.isEmpty {
                    ownCameraView.attach(participant: participant, stream: stream)
                    ownCameraView.isHidden = false
                }
            } else {
                tableView.reloadData()
            }
        case .ScreenShare:
            // Attaching a video stream to a renderer.
            screenShareView.attach(participant: participant, stream: stream)
            screenShareView.alpha = 1
        default:
            break
        }
    }
    
    func streamUpdated(participant: VTParticipant, stream: MediaStream) {
        // Get the video renderer.
        if participant.id == VoxeetSDK.shared.session.participant?.id {
            // Attaching own participant's video stream to the renderer.
            if !stream.videoTracks.isEmpty {
                ownCameraView.attach(participant: participant, stream: stream)
            }
            ownCameraView.isHidden = stream.videoTracks.isEmpty
        } else if let index = activeParticipants().firstIndex(where: { $0.id == participant.id }) {
            tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
        }
    }
    
    func streamRemoved(participant: VTParticipant, stream: MediaStream) {
        switch stream.type {
        case .Camera:
            tableView.reloadData()
        case .ScreenShare:
            screenShareView.alpha = 0
        default:
            break
        }
    }
}

/*
 *  MARK: - Conference encryption delegate
 */

extension ConferenceViewController: VTConferenceCryptoDelegate {
    func encrypt(type: Int, ssrc: Int, frame: UnsafePointer<UInt8>, frameSize: Int, encryptedFrame: UnsafeMutablePointer<UInt8>, encryptedFrameSize: Int) -> Int {
        let buffer = UnsafeBufferPointer(start: frame, count: frameSize)
        let encryptedBuffer = UnsafeMutableBufferPointer(start: encryptedFrame, count: encryptedFrameSize)
        
        // Without any cryptography.
        memcpy(encryptedBuffer.baseAddress, buffer.baseAddress, frameSize)
        
        return encryptedFrameSize
    }
    
    func getMaxCiphertextByteSize(type: Int, size: Int) -> Int {
        return size
    }
    
    func decrypt(type: Int, ssrc: Int, encryptedFrame: UnsafePointer<UInt8>, encryptedFrameSize: Int, frame: UnsafeMutablePointer<UInt8>, frameSize: Int) -> Int {
        let encryptedBuffer = UnsafeBufferPointer(start: encryptedFrame, count: encryptedFrameSize)
        let buffer = UnsafeMutableBufferPointer(start: frame, count: frameSize)
        
        // Without any cryptography.
        memcpy(buffer.baseAddress, encryptedBuffer.baseAddress, encryptedFrameSize)
        
        return frameSize
    }
    
    func getMaxPlaintextByteSize(type: Int, size: Int) -> Int {
        return size
    }
}

/*
 *  MARK: - Command delegate
 */

extension ConferenceViewController: VTCommandDelegate {
    func received(participant: VTParticipant, message: String) {
        broadcastMessageTextView.text = "\(participant.info.name ?? participant.id ?? ""): \(message)"
    }
}

/*
 *  MARK: - File presentation delegate
 */

extension ConferenceViewController: VTFilePresentationDelegate {
    func converted(fileConverted: VTFileConverted) {}
    
    func started(filePresentation: VTFilePresentation) {
        updated(filePresentation: filePresentation)
    }
    
    func updated(filePresentation: VTFilePresentation) {
        let fileURL = VoxeetSDK.shared.filePresentation.image(page: filePresentation.position)
        
        if let url = fileURL {
            do {
                let data = try Data(contentsOf: url)
                let image = UIImage(data: data)
                filePresentationImageView.image = image
                filePresentationImageView.isHidden = false
            } catch {}
        }
    }
    
    func stopped(filePresentation: VTFilePresentation) {
        filePresentationImageView.image = nil
        filePresentationImageView.isHidden = true
    }
}

/*
 *  MARK: - Video presentation delegate
 */

extension ConferenceViewController: VTVideoPresentationDelegate {
    func started(videoPresentation: VTVideoPresentation) {
        player = AVPlayer(url: videoPresentation.url)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = videoPresentationView.bounds
        playerLayer.backgroundColor = UIColor.black.cgColor
        videoPresentationView.layer.addSublayer(playerLayer)
        
        player?.play()
        player?.seek(to: CMTimeMakeWithSeconds(videoPresentation.timestamp / 1000, preferredTimescale: 1000))
        
        videoPresentationView.isHidden = false
    }
    
    func stopped(videoPresentation: VTVideoPresentation) {
        player?.pause()
        player = nil
        videoPresentationView.isHidden = true
    }
    
    func played(videoPresentation: VTVideoPresentation) {
        player?.seek(to: CMTimeMakeWithSeconds(videoPresentation.timestamp / 1000, preferredTimescale: 1000))
        player?.play()
    }
    
    func paused(videoPresentation: VTVideoPresentation) {
        player?.pause()
        player?.seek(to: CMTimeMakeWithSeconds(videoPresentation.timestamp / 1000, preferredTimescale: 1000))
    }
    
    func sought(videoPresentation: VTVideoPresentation) {
        player?.seek(to: CMTimeMakeWithSeconds(videoPresentation.timestamp / 1000, preferredTimescale: 1000))
    }
}
