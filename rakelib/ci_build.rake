# frozen_string_literal: true

require_relative 'ci_build'

namespace :au_core do
  namespace :ci_build do
    desc 'Report whether the AU Core CI build has changed since the ci-build suite was generated'
    task :check do
      ci_build = AUCoreTestKit::CIBuild.new
      published = ci_build.published_manifest
      changed = published['date'] != ci_build.recorded_date
      puts "CI build #{published['version']} dated #{published['date']}; " \
           "ci-build suite generated from #{ci_build.recorded_date}: #{changed ? 'changed' : 'unchanged'}"
      AUCoreTestKit::CIBuild.write_github_output(changed:)
    end

    desc 'Download the AU Core CI build package into lib/au_core_test_kit/igs/ci-build.tgz'
    task :download do
      AUCoreTestKit::CIBuild.new.download
    end

    desc 'Regenerate the ci-build suite when the AU Core CI build has changed (pass "force" to always regenerate)'
    task :refresh, [:force] do |_task, args|
      ci_build = AUCoreTestKit::CIBuild.new
      changed = args[:force] == 'force' || ci_build.changed?
      if changed
        ci_build.download
        Rake::Task['au_core:generate'].invoke('ci-build')
        puts "Regenerated the ci-build suite from #{ci_build.version} dated #{ci_build.recorded_date}"
      else
        puts "CI build unchanged since #{ci_build.recorded_date}; nothing to regenerate"
      end
      AUCoreTestKit::CIBuild.write_github_output(changed:, version: ci_build.version, date: ci_build.recorded_date)
    end
  end
end
