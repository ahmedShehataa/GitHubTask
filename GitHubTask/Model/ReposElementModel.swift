//
//  reposModel.swift
//  GitHubTask
//
//  Created by Shehata on 12/25/19.
//  Copyright © 2019 shehata. All rights reserved.
//

import Foundation

// MARK: - ReposModelElement
struct ReposElementModel: Codable {
    
    let homepage: String?
    let eventsURL, svnURL: String?
    let openIssues: Int?
    let pullsURL: String?
    let watchers: Int?
    let hasDownloads: Bool?
    let labelsURL: String?
    let defaultBranch: DefaultBranch?
    let contentsURL: String?
    let languagesURL: String?
    let issuesURL: String?
    let openIssuesCount: Int?
    let hasPages, hasIssues: Bool?
    let cloneURL: String?
    let tagsURL, contributorsURL: String?
    let disabled: Bool?
    let milestonesURL, collaboratorsURL, archiveURL: String?
    let forksCount, stargazersCount: Int?
    let url: String?
    let hasProjects: Bool?
    let language: String?
    let deploymentsURL: String?
    let nodeID, releasesURL, gitURL, treesURL: String?
    let notificationsURL, reposModelDescription: String?
    let license: License?
    let reposModelPrivate: Bool?
    let branchesURL, commentsURL: String?
    let forksURL, teamsURL: String?
    let owner: Owner?
    let stargazersURL, htmlURL: String?
    let gitTagsURL, fullName: String?
    let pushedAt: Date?
    let forks: Int?
    let archived: Bool?
    let issueCommentURL, name, blobsURL: String?
    let downloadsURL: String?
    let statusesURL, gitRefsURL: String?
    let createdAt: Date?
    let assigneesURL, compareURL: String?
    let subscribersURL: String?
    let watchersCount: Int?
    let keysURL, gitCommitsURL, commitsURL: String?
    let fork: Bool
    let updatedAt: Date?
    let mirrorURL: String?
    let hasWiki: Bool?
    let issueEventsURL: String?
    let hooksURL, subscriptionURL, mergesURL: String?
    let id: Int?
    let sshURL: String?
    let size: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case nodeID = "node_id"
        case name
        case fullName = "full_name"
        case reposModelPrivate = "private"
        case owner
        case htmlURL = "html_url"
        case reposModelDescription = "description"
        case fork, url
        case forksURL = "forks_url"
        case keysURL = "keys_url"
        case collaboratorsURL = "collaborators_url"
        case teamsURL = "teams_url"
        case hooksURL = "hooks_url"
        case issueEventsURL = "issue_events_url"
        case eventsURL = "events_url"
        case assigneesURL = "assignees_url"
        case branchesURL = "branches_url"
        case tagsURL = "tags_url"
        case blobsURL = "blobs_url"
        case gitTagsURL = "git_tags_url"
        case gitRefsURL = "git_refs_url"
        case treesURL = "trees_url"
        case statusesURL = "statuses_url"
        case languagesURL = "languages_url"
        case stargazersURL = "stargazers_url"
        case contributorsURL = "contributors_url"
        case subscribersURL = "subscribers_url"
        case subscriptionURL = "subscription_url"
        case commitsURL = "commits_url"
        case gitCommitsURL = "git_commits_url"
        case commentsURL = "comments_url"
        case issueCommentURL = "issue_comment_url"
        case contentsURL = "contents_url"
        case compareURL = "compare_url"
        case mergesURL = "merges_url"
        case archiveURL = "archive_url"
        case downloadsURL = "downloads_url"
        case issuesURL = "issues_url"
        case pullsURL = "pulls_url"
        case milestonesURL = "milestones_url"
        case notificationsURL = "notifications_url"
        case labelsURL = "labels_url"
        case releasesURL = "releases_url"
        case deploymentsURL = "deployments_url"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case pushedAt = "pushed_at"
        case gitURL = "git_url"
        case sshURL = "ssh_url"
        case cloneURL = "clone_url"
        case svnURL = "svn_url"
        case homepage, size
        case stargazersCount = "stargazers_count"
        case watchersCount = "watchers_count"
        case language
        case hasIssues = "has_issues"
        case hasProjects = "has_projects"
        case hasDownloads = "has_downloads"
        case hasWiki = "has_wiki"
        case hasPages = "has_pages"
        case forksCount = "forks_count"
        case mirrorURL = "mirror_url"
        case archived, disabled
        case openIssuesCount = "open_issues_count"
        case license, forks
        case openIssues = "open_issues"
        case watchers
        case defaultBranch = "default_branch"
    }
}

enum DefaultBranch: String, Codable {
    case master = "master"
}

// MARK: - License
struct License: Codable {
    let key: Key?
    let name: Name?
    let spdxID: SpdxID?
    let url: String?
    let nodeID: LicenseNodeID?
    
    enum CodingKeys: String, CodingKey {
        case key, name
        case spdxID = "spdx_id"
        case url
        case nodeID = "node_id"
    }
}

enum Key: String, Codable {
    case apache20 = "apache-2.0"
    case mit = "mit"
    case other = "other"
}

enum Name: String, Codable {
    case apacheLicense20 = "Apache License 2.0"
    case mitLicense = "MIT License"
    case other = "Other"
}

enum LicenseNodeID: String, Codable {
    case mDc6TGljZW5ZZTA = "MDc6TGljZW5zZTA="
    case mDc6TGljZW5ZZTEz = "MDc6TGljZW5zZTEz"
    case mDc6TGljZW5ZZTI = "MDc6TGljZW5zZTI="
}

enum SpdxID: String, Codable {
    case apache20 = "Apache-2.0"
    case mit = "MIT"
    case noassertion = "NOASSERTION"
}

// MARK: - Owner
struct Owner: Codable {
    let login: String?
    let id: Int?
    let nodeID: OwnerNodeID?
    let avatarURL: String?
    let gravatarID: String?
    let url, htmlURL, followersURL: String?
    let followingURL: FollowingURL?
    let gistsURL: GistsURL?
    let starredURL: StarredURL?
    let subscriptionsURL, organizationsURL, reposURL: String?
    let eventsURL: EventsURL?
    let receivedEventsURL: String?
    let type: TypeEnum?
    let siteAdmin: Bool?
    
    enum CodingKeys: String, CodingKey {
        case login, id
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
        case url
        case htmlURL = "html_url"
        case followersURL = "followers_url"
        case followingURL = "following_url"
        case gistsURL = "gists_url"
        case starredURL = "starred_url"
        case subscriptionsURL = "subscriptions_url"
        case organizationsURL = "organizations_url"
        case reposURL = "repos_url"
        case eventsURL = "events_url"
        case receivedEventsURL = "received_events_url"
        case type
        case siteAdmin = "site_admin"
    }
}

enum EventsURL: String, Codable {
    case httpsAPIGithubCOMUsersSquareEventsPrivacy = "https://api.github.com/users/square/events{/privacy}"
}

enum FollowingURL: String, Codable {
    case httpsAPIGithubCOMUsersSquareFollowingOtherUser = "https://api.github.com/users/square/following{/other_user}"
}

enum GistsURL: String, Codable {
    case httpsAPIGithubCOMUsersSquareGistsGistID = "https://api.github.com/users/square/gists{/gist_id}"
}


enum OwnerNodeID: String, Codable {
    case mdEyOk9YZ2FuaXphdGlvbjgyNTky = "MDEyOk9yZ2FuaXphdGlvbjgyNTky"
}

enum StarredURL: String, Codable {
    case httpsAPIGithubCOMUsersSquareStarredOwnerRepo = "https://api.github.com/users/square/starred{/owner}{/repo}"
}

enum TypeEnum: String, Codable {
    case organization = "Organization"
}

typealias ReposModel = [ReposElementModel]


